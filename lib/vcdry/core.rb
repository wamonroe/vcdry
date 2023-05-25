require "active_support/concern"
require "active_support/core_ext/hash"
require "active_support/core_ext/module/delegation"

require_relative "error"
require_relative "registry"

module VCDry
  module Core
    extend ActiveSupport::Concern

    def vcdry_parse_keywords(kwargs = {})
      kwargs = kwargs.symbolize_keys
      self.class.vcdry.keyword_configs.each do |config|
        if config.required? && !kwargs.key?(config.name)
          raise MissingRequiredKeywordError.new(config.name)
        end

        value = kwargs.fetch(config.name, config.default)
        instance_variable_set(config.instance_variable, config.type_cast(value))
      end
      kwargs.except(*self.class.vcdry.keywords)
    end

    class_methods do
      delegate :remove_keyword, to: :vcdry

      def inherited(subclass)
        subclass.instance_variable_set(:@vcdry, @vcdry&.dup)
        super
      end

      def keyword(name, type = nil, **options)
        name = name.to_sym
        config = vcdry.keyword(name, type, options)
        vcutils_define_helper_methods(config)
      end

      def vcdry
        @vcdry ||= Registry.new
      end

      def vcutils_define_helper_methods(config)
        if config.enum?
          config.enum_values.each do |value|
            define_method "#{config.name}_#{value}?" do
              instance_variable_get(config.instance_variable) == value
            end
          end
        end
        if config.optional?
          define_method "#{config.name}?" do
            instance_variable_get(config.instance_variable).present?
          end
        end
      end
    end
  end
end

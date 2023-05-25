require "active_model/callbacks"
require "active_support/concern"

require_relative "core"
require_relative "error"

module VCDry
  module DSL
    extend ActiveSupport::Concern
    include Core

    included do
      extend ActiveModel::Callbacks

      define_model_callbacks :initialize
    end

    def initialize(**kwargs)
      run_callbacks :initialize do
        unknown_kwargs = vcdry_parse_keywords(kwargs)
        vcdry_parse_unknown_keywords(unknown_kwargs)
        super
      end
    end

    def vcdry_parse_unknown_keywords(unknown_kwargs = {})
      raise UnknownArgumentError.new(*unknown_kwargs.keys) if self.class.vcdry.strict? && unknown_kwargs.present?
      return unless self.class.vcdry.gather_unknown_keywords?

      config = self.class.vcdry.other_keywords_config
      instance_variable_set(config.instance_variable, config.type_cast(unknown_kwargs))
    end

    class_methods do
      delegate :other_keywords, :strict_keywords, to: :vcdry
    end
  end
end

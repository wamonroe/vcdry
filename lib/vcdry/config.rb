require "active_support/core_ext/enumerable"

require_relative "error"
require_relative "types"

module VCDry
  class Config
    NOT_DEFINED = Object.new.freeze

    attr_reader :name

    def initialize(name, type = nil, **options)
      @name = name.to_sym
      @type = (type.nil? || type.respond_to?(:call)) ? type : VCDry::Types[type]
      @options = options
    end

    def array?
      !!@options[:array]
    end

    def default?
      @options.key?(:default)
    end

    def dup
      self.class.new(@name, @type, **@options.dup)
    end

    def enum?
      @options.key?(:values)
    end

    def enum_values
      @enum_values ||= Array(@options[:values]).map do |value|
        @type.nil? ? value : @type.call(value)
      end
    end

    def default
      value = @options.fetch(:default, NOT_DEFINED)
      value = value.call if value.respond_to?(:call)
      value
    end

    def instance_variable
      "@#{name}"
    end

    def optional?
      default? || !!@options[:optional]
    end

    def required?
      !optional?
    end

    def type_cast(value)
      array? ? type_cast_array(value) : type_cast_value(value)
    end

    private

    def type_cast_array(values)
      return if values == NOT_DEFINED

      Array(values).map do |value|
        type_cast_value(value)
      end
    end

    def type_cast_value(value)
      return if value == NOT_DEFINED
      return value if @type.nil?

      value = @type.call(value)
      if enum? && enum_values.exclude?(value)
        raise InvalidEnumValueError.new(name, enum_values)
      end
      value
    end
  end
end

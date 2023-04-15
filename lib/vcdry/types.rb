require "active_support/core_ext/module/delegation"

module VCDry
  module Types
    class << self
      delegate :add_type, :remove_type, :[], to: :registry

      private

      def registry
        @registry ||= TypeRegistry.new
      end
    end

    class TypeRegistry
      def initialize
        @types = {
          boolean: ->(value) { !!value },
          datetime: ->(value) { value.to_datetime },
          hash: ->(value) { value.to_h },
          integer: ->(value) { value.to_i },
          string: ->(value) { value.to_s },
          symbol: ->(value) { value.to_s.to_sym }
        }
      end

      def add_type(name, method)
        raise TypeError, "method must respond to #call" unless method.respond_to?(:call)

        @types[name] = method
      end

      def [](name)
        @types.fetch(name)
      rescue KeyError
        raise UnknownTypeError.new(name)
      end
    end
  end
end

module VCDry
  class Error < StandardError; end

  class InvalidEnumValueError < Error
    def initialize(name, values)
      super("value for #{name} must be one of '#{values.join("', '")}'")
    end
  end

  class MissingRequiredKeywordError < Error
    def initialize(name)
      super("missing required keyword: :#{name}")
    end
  end

  class ReservedNameError < Error
    def initialize(name)
      super("'#{name}' is used to gather unknown keywords")
    end
  end

  class UnknownArgumentError < Error
    def initialize(*names)
      super("unknown keyword: :#{names.join(" :")}")
    end
  end

  class UnknownTypeError < Error
    def initialize(type)
      super("unknown type: #{type}")
    end
  end
end

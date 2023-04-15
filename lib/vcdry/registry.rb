require_relative "config"
require_relative "error"

module VCDry
  class Registry
    attr_reader :other_keywords_config

    def initialize
      @keywords = {}
      @other_keywords_config = nil
      @strict = true
    end

    def dup
      object = self.class.new
      keywords = {}
      @keywords.each do |name, config|
        keywords[name] = config.dup
      end
      object.instance_variable_set(:@keywords, keywords)
      object.instance_variable_set(:@other_keywords_config, @other_keywords_config&.dup)
      object.instance_variable_set(:@strict, @strict)
      object
    end

    def gather_unknown_keywords?
      !@other_keywords_config.nil?
    end

    def keyword(name, type, options = {})
      raise ReservedNameError.new(name) if @other_keywords_config&.name == name.to_sym

      @keywords[name] = Config.new(name, type, **options)
    end

    def keyword_configs
      @keywords.values
    end

    def keywords
      @keywords.keys
    end

    def other_keywords(name, type: :hash)
      @other_keywords_config = Config.new(name, type)
    end

    def strict?
      !gather_unknown_keywords? && @strict
    end

    def strict_keywords(value)
      @strict = !!value
    end

    def remove_keyword(name)
      @keywords.delete(name)
    end
  end
end

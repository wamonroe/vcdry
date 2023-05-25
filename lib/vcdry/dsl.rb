require "active_model/callbacks"
require "active_support/concern"

require_relative "core"

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
        vcdry_parse(**kwargs)
        super
      end
    end
  end
end

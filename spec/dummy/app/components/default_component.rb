class DefaultComponent < ApplicationComponent
  keyword :string, :string, default: "default"
  keyword :another_string, :string, default: -> { "default" }
end

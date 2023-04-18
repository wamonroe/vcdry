class DefaultComponent < ApplicationComponent
  keyword :string, :string, default: "default"
  keyword :another_string, :string, default: -> { "default" }
  keyword :integer_1, :integer, default: nil
  keyword :integer_2, :integer, optional: true
end

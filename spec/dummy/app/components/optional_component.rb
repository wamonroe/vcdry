class OptionalComponent < ApplicationComponent
  keyword :name, :symbol, optional: true
  keyword :color, :symbol, default: :primary,
    values: %i[primary secondary tertiary]
end

class RequiredComponent < ApplicationComponent
  keyword :name, :symbol
  keyword :color, :symbol, values: %i[primary secondary tertiary]
end

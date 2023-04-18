class ValuesComponent < ApplicationComponent
  keyword :size, :symbol, values: %i[sm md lg], optional: true
  keyword :padding, :symbol, default: :md, values: %i[sm md lg]
  keyword :margin, :symbol, default: :md, values: %i[sm md lg], optional: true
end

class ParentComponent < ApplicationComponent
  keyword :name, :string
  keyword :favorite_food, :string, default: "Pizza"
  keyword :retired, :boolean, optional: true
  other_keywords :options
end

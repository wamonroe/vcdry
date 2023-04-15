class ChildComponent < ParentComponent
  keyword :favorite_food, :string, default: "Tacos"
  keyword :age, :integer
  remove_keyword :retired
end

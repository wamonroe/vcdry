class TypesComponent < ApplicationComponent
  keyword :no_type, optional: true
  keyword :boolean, :boolean, optional: true
  keyword :datetime, :datetime, optional: true
  keyword :hash, :hash, optional: true
  keyword :integer, :integer, optional: true
  keyword :string, :string, optional: true
  keyword :symbol, :symbol, optional: true
  keyword :custom_proc, ->(value) { "custom #{value}" }, optional: true
  keyword :custom_hash, :custom_hash, optional: true
end

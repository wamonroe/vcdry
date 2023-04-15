class ApplicationRecord < ActiveRecord::Base
  if Gem.loaded_specs["rails"].version >= "7.0"
    primary_abstract_class
  else
    self.abstract_class = true
  end
end

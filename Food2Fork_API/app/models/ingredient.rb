class Ingredient < ActiveRecord::Base
  has_many :cookings 
end

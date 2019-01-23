class Ingredient < ActiveRecord::Base
  has_many :cookings
  has_many :meals, through: :cookings

end

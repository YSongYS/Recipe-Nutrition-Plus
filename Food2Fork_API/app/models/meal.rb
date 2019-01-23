require_relative '../../config/environment'

class Cooking < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients, through: :cookings
end

require_relative '../../config/environment'

class Meal < ActiveRecord::Base
  belongs_to :user
  has_many :cookings
  has_many :ingredients, through: :cookings


  def cooking(ingredients)
    Cooking.cook_the_meal(ingredients, self.id)
  end

  def meal_nutrition
    nutrition_na = []
    calories, carbo, fat, protein = 0, 0, 0, 0
    serving = 5

    Cooking.where(meal_id: self.id).each do |cooking|
      # if ingredient not recognizable, put it into the nutrition na string to build the notes to user later
      if cooking.ingredient_id == nil
        nutrition_na << cooking.ingredient_na

      # for known ingredient, calculate the portion used in recipe vs. in standard table
      else
        ingredient = Ingredient.find(cooking.ingredient_id)
        if cooking.unit_v_or_w == "v"
          portion = cooking.volume_in_cup/ingredient.equivalent_volume_cup
        elsif cooking.unit_v_or_w == "w"
          portion = cooking.weight_in_g/ingredient.equivalent_weight_g
        else
          portion = cooking.usage
        end

        # get ingredient nutrition values and multiply by portion
        calories += ingredient.calories_kCal * portion / serving
        carbo += ingredient.carbo_g * portion / serving
        fat += ingredient.fat_g * portion / serving
        protein += ingredient.protein_g * portion / serving
      end
    end

    return calories, carbo, fat, protein, nutrition_na
  end

end

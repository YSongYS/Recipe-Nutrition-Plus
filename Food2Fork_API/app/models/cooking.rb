require_relative '../../config/environment'

class Cooking < ActiveRecord::Base

  def self.cook_the_meal (ingredient_line, meal_id)
    ingredient_line.each do |ingredient_line|
      item = ""

      # if there is number to read
      if ingredient_line.to_f == 0
        ingredient = ingredient_line
      else
        parsed_line = ingredient_line.split(' ',3)
        ingredient = parsed_line[2]

        # first read the number out by converting integer/fraction/monsters to float
        usage = number_reader(parsed_line[0])
        # sanitize the unit to standarized
        common_unit = unit_converter(parsed_line[1])
        unit_v_or_w = v_or_w_identifier(common_unit)

        # convert common unit into standarized volume or weight unit
        if unit_v_or_w == "v"
          volume_in_cup = volume_converter(usage, common_unit)
        elsif unit_v_or_w == "w"
          weight_in_g = weight_converter(usage,common_unit)
        else
          ingredient = parsed_line[1..2].join(" ")
        end
      end

      ingredient_id = Cooking.fuzzy_search_ingredient(item, unit_v_or_w)
      Cooking.create(meal_id:meal_id, ingredient_id:ingredient_id, usage:usage, common_unit:common_unit, unit_v_or_w:unit_v_or_w)
    end
  end

  def self.fuzzy_search_ingredient(item, unit_v_or_w)
    if unit_v_or_w == "w"
      # search for the first match
      Ingredient.all.each do |ingredient|
        return ingredient.id if item.include?(ingredient.ingredient_name)
      end
    else
      # search for the firsth match with similar name and same unit_v_or_w type
      Ingredient.all.each do |ingredient|
        return ingredient.id if item.include?(ingredient.ingredient_name) && ingredient.unit_v_or_w == unit_v_or_w
      end
    end
  end


end

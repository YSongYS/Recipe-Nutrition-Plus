require_relative '../../config/environment'

class Ingredient < ActiveRecord::Base

  def cook_the_meal (ingredient_line, meal_id)
    ingredient_line.each do |ingredient_line|

      # if no number were given in the ingredient_line, save as nil usage
      if ingredient_line.to_f == 0
        usage, unit, unit_v_or_w = nil, nil, nil
      else
        parsed_line = ingredient_line.split(' ',3)
        # first read the number out by converting integer/fraction/monsters to float
        usage = number_reader(parsed_line[0])
        # sanitize the unit to standarized
        unit = unit_converter(parsed_line[1])
        unit_v_or_w = v_or_w_identifier(unit)
      end
      Ingredient.create(meal_id:meal_id, ingredient_id:ingredient_id, usage:usage, unit:unit, unit_v_or_w:unit_v_or_w)
    end
  end

end

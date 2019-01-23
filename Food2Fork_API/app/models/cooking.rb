require_relative '../../config/environment'
# #cook_the_meal, cook rows and rows of ingredient into the Cookings table
# #fuzzy_search_ingredient, a private method to support cook_the_meal

class Cooking < ActiveRecord::Base

  def self.cook_the_meal (ingredient_line, meal_id)
    ingredient_line.each do |ingredient_line|
      @@item, @@parsed_line, @@common_unit, @@usage, @@unit_v_or_w, @@volume_in_cup, @@weight_in_g, @@ingredient_id, @@new_ingredient = nil, nil, nil, nil, nil, nil, nil, nil, nil
      @@new_ingredient = Cooking.create
      # if there is no number to read, read the whole line as the item
      if ingredient_line.to_f == 0
        @@item = ingredient_line
      # if there is number to read, see if the is unit to read
      else
        @@parsed_line = ingredient_line.split(' ',3)
        # put first element as number
        @@usage = number_reader(@@parsed_line[0])
        # read second element as unit
        @@common_unit = unit_converter(@@parsed_line[1])
        @@unit_v_or_w = v_or_w_identifier(@@common_unit)
        # default the item into third element assuming the unit was read properly
        @@item = @@parsed_line[2]

        # populate the volume in cup and weight in g
        if @@unit_v_or_w == "v"
          @@volume_in_cup = volume_converter(@@usage,@@common_unit)
        elsif @@unit_v_or_w == "w"
          @@weight_in_g = weight_converter(@@usage,@@common_unit)
        # if unit is not read properly, it will show up as type monster, item will need to be redefined as 1 & 2 elements
        else
          @@item = @@parsed_line[1..2].join(" ")
        end
      end

      @@ingredient_id = @@new_ingredient.fuzzy_search_ingredient(@@item, @@unit_v_or_w)

      @@new_ingredient.update(meal_id: meal_id, ingredient_id: @@ingredient_id, usage: @@usage, common_unit: @@common_unit, unit_v_or_w: @@unit_v_or_w, volume_in_cup: @@volume_in_cup, weight_in_g: @@weight_in_g)
    end
  end

  def fuzzy_search_ingredient(item, unit_v_or_w)
    if unit_v_or_w == "w"
      # search for the first match
      Ingredient.all.each do |ingredient|
        return ingredient.id if fuzzy_matching(ingredient.ingredient_long_name,ingredient.ingredient_name,item)
      end
    else
      # search for the firsth match with similar name and same unit_v_or_w type
      Ingredient.all.each do |ingredient|
        return ingredient.id if fuzzy_matching(ingredient.ingredient_long_name,ingredient.ingredient_name,item) && ingredient.unit_v_or_w == unit_v_or_w
      end
    end
    return nil
  end

end

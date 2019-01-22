require_relative '../config/environment'

user_input = get_user_crave
recipes = get_top_recipes(user_input)
print_top_x(recipes, 5)
#selected_num = get_user_select
selected_num = 1
30.times do
  ingredients = get_selected_recipes(selected_num, recipes)
  File.write('app/data_cleaning/ingredient_sandbox.md',ingredients)
  #puts ingredients
  selected_num += 1
end
puts "the end"

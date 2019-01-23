require_relative '../config/environment'


# gets.chomp
 user_input = get_user_crave
 recipes = get_top_recipes(user_input)
# print_top_x(recipes, 5)
# #selected_num = get_user_select
# selected_num = 1
# RECIPES = []
# 10.times do
#   RECIPES << get_selected_recipes(selected_num, recipes)
   #puts ingredients
#   selected_num += 1
# end
# return RECIPES
# puts "the end"

RECIPES = ["1 pound Italian Sausage",
"1 pound Ground Beef",
"1 can (28 Ounce Can) Whole Tomatoes, With Juice",
"2 cans (14.5 Ounce) Tomato Sauce Or Marinara Sauce",
"2 teaspoons Italian Seasoning",
"1/2 teaspoon Red Pepper Flakes",
"Salt And Pepper, to taste",
"16 ounces, weight Ziti Or Mostaciolli, Cooked Until Not Quite Al Dente",
"1 tub (15 Ounce) Whole Milk Ricotta Cheese",
"1-1/2 pound Mozzarella Cheese, Grated",
"1/2 cup Grated Parmesan Cheese",
"1 whole Egg",
"Fresh Minced Parsley",
"1/2 pound ground beef",
"6 strips bacon, cut into 1 inch pieces",
"1 small onion, diced",
"1 clove garlic, chopped",
"4 ounces cream cheese, room temperature",
"1/2 cup sour cream",
"1/4 cup mayonnaise",
"1/2 cup mozzarella, shredded",
"1/2 cup cheddar cheese, shredded",
"1 tablespoon worcestershire sauce",
"2 tablespoon ketchup",
"2 Tablespoons Butter",
"2 whole Large Onions, Halved And Sliced Thin",
"1/4 cup Beef Broth",
"7 dashes Worcestershire Sauce",
"Splash Of Red Or White Wine",
"1/2 cup Grated Gruyere Cheese (can Use Swiss)",
"Kosher Salt",
"24 whole White Or Crimini Mushrooms, Washed And Stems Removed",
"Minced Parsley",
"1-1/2 pound Ground Beef"]

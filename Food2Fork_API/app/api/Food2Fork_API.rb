# require_relative '../../config/environment'

def get_user_crave(day_of_the_week, meal_type)
  puts "Happy #{day_of_the_week}! What do you feel like having for #{meal_type}?".green
  user_input = STDIN.gets.chomp
  return user_input
end

def get_user_select
  puts ""
  puts "Which recipe would you like to go with?".green
  selected_num = STDIN.gets.chomp.to_i
  slowprint(".. cooking the meal".split)
  print "\n"
  slowprint(".. eating the meal".split)
  print "\n"
  return selected_num
end


# given user_input on key gredient or receipe name, return the URL to retrieve recipe search data from API
def top_recipe_URL(user_input, api_key)
  key_word_chain = user_input.split(" ").map(&:downcase).join("%20")
  recipes_URL = "https://www.food2fork.com/api/search?key=#{api_key}&q=#{key_word_chain}&page=1"
  return recipes_URL
end

# given user_input on key gredient or receipe name, return the top recipe search researchs in an array of hashes
# CHANGE CHANGE CHANGE add filter to elimnate bad recipes, such as fries 3
def get_top_recipes (user_input)
  api_key = "1469fbff5fa553becb01a5b3a5ef1d71"
  recipes_URL = top_recipe_URL(user_input, api_key)
  uri = URI.parse(recipes_URL)
  response = Net::HTTP.get_response(uri).body
  recipes = eval(response)[:recipes]
  return recipes
end

# print out title of the top x recipes for user to choose from
def print_top_x (user_input,recipes, top_x)
  index = 0
  puts ""
  puts "Here are the top recipes for #{user_input.downcase}"
  while index < top_x do
    puts "   #{index+1}. #{recipes[index][:title]}"
    index += 1
  end
end

# given number of the selected id, the recipe hash and the api key, return the URL to retrive API data on the selected recipe
def selected_recipe_URL(selected_num, recipes, api_key)
  recipe_id = recipes[selected_num - 1][:recipe_id]
  recipe_URL = "https://www.food2fork.com/api/get?key=#{api_key}&rId=#{recipe_id}"
  return recipe_URL
end

def get_selected_recipes(selected_num, recipes)
  api_key = "1469fbff5fa553becb01a5b3a5ef1d71"
  recipe_URL = selected_recipe_URL(selected_num, recipes, api_key)
  uri = URI.parse(recipe_URL)
  response = Net::HTTP.get_response(uri).body
  ingredients = eval(response)[:recipe][:ingredients]
  recipe_id = recipes[selected_num - 1][:recipe_id]
  recipe_name = recipes[selected_num - 1][:title]
  return recipe_id, recipe_name, ingredients
end

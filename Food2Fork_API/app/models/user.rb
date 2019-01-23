# .register_new_user register a new user and auto popualte all target info (every functions before that supports it)
require_relative '../../config/environment'


class User < ActiveRecord::Base
  has_many :meals

  def calculate_store_bmr
  # BMR Male
  # (10 × weight in kg) + (6.25 × height in cm) - (5 × age in years) + 5
    if self.gender == "male"
      self.bmr = (10 * self.weight) + (6.25 * self.height) - (5 * self.age) + 5
  # BMR Female
  # (10 × weight in kg) + (6.25 × height in cm) - (5 × age in years) - 161
    elsif self.gender == "female"
      self.bmr = (10 * self.weight) + (6.25 * self.height) - (5 * self.age) - 161
    end
  end

  # calculate macro targets helpers

  def calculate_store_carbo_target
    self.carbo_target = (self.bmr * 0.5) / 4
  end

  def calculate_store_protein_target
    self.protein_target = (self.bmr * 0.15) / 4
  end

  def calculate_store_fat_target
    self.fat_target = (self.bmr * 0.35) / 9
  end

# calculate macro targets
  def calculate_macros
    calculate_store_fat_target
    calculate_store_protein_target
    calculate_store_carb_target
  end

## Get user info helper methods sdout ##
  # Enter your name
  def get_user_name
    puts "Please enter you name:"
    user_input = STDIN.gets.chomp
    # self.name = user_input
  end

  # Enter your gender
  def get_user_gender
    puts "Please input your gender (Male/Female):"
    user_input = STDIN.gets.chomp.downcase
  end

# Enter your age
  def get_user_age
    puts "Please input your age:"
    user_input = STDIN.gets.chomp.to_i
  end

# Enter your height
  def get_user_height
    puts "Please input your height in cm:"
    user_input = STDIN.gets.chomp.to_i
  end

# Enter your weight
  def get_user_weight
    puts "Please input your weight in kg:"
    user_input = STDIN.gets.chomp.to_i
  end

# create new user, ask for info, save to table
  def self.register_new_user
    new_user = User.create
    new_user.name = new_user.get_user_name
    new_user.gender = new_user.get_user_gender
    new_user.age = new_user.get_user_age
    new_user.height = new_user.get_user_height
    new_user.weight = new_user.get_user_weight
    new_user.calculate_store_bmr
    new_user.carbo_target =  new_user.calculate_store_carbo_target
    new_user.protein_target = new_user.calculate_store_protein_target
    new_user.fat_target = new_user.calculate_store_fat_target
    new_user.save
  end


  # calculate weekly calories through meals
  # taking nutrition info from ingredients
  # meals.user.each do {sum}

  def my_weekly_targets
    bmr_target = self.brm * 7
    carbo = self.carbo_target * 7
    fat = self.fat_target * 7
    protein = self.protein_target * 7
    return bmr_target, carbo, fat, protein
  end

  def eating(day_of_the_week, meal_type)
    user_input = get_user_crave
    recipes = get_top_recipes(user_input)
    print_top_x(recipes, 5)
    selected_num = get_user_select
    @recipe_id, @meal_name, ingredients = get_selected_recipes(selected_num, recipes)
    @new_meal = Meal.create(user_id: self.id, day_of_the_week: day_of_the_week, meal_type: meal_type, meal_name: @meal_name, recipe_id: @recipe_id)
    @new_meal.cooking(ingredients)
  end

  # calculate calories so far this week
  # find all meals for self that have been eaten in the last week
  # for each meal get full list of ingredients
  # for each ingredient calculate calories
  def calories_consumed_this_week
    trash_can = []
    calories, carbo, fat, protein = 0, 0, 0, 0
    Meal.where(user_id: self.id).each do |meal|
      cal, cab, f, pro, trash_can = meal.meal_nutrition
      calories += cal
      carbo += cab
      fat += f
      protein += pro
    end
    return calories, carbo, fat, protein
  end

  def compare_calorie_target_to_calories_consumed
    # compare to my_weekly_calorie_target
    puts "You have eaten #{self.calories_consumed_this_week / self.my_weekly_calorie_target * 100}% of your weekly calorie target."

  end

  def print_nutritional_report
    my_summary = {}
    calories, carbo, fat, protein = self.calories_consumed_this_week

    my_summary["calories"] = [calories]
    my_summary["carbo"] = [carbo]
    my_summary["fat"] = [fat]
    my_summary["protein"] = [protein]

    my_summary["calories"] << self.bmr * 7
    my_summary["carbo"] << self.carbo_target * 7
    my_summary["fat"] << self.fat_target * 7
    my_summary["protein"] << self.protein_target * 7

    puts my_summary
  end
end

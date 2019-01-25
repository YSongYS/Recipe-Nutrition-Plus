# .register_new_user register a new user and auto popualte all target info (every functions before that supports it)
require_relative "../../config/environment"


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
    prompt = TTY::Prompt.new
    user_input = prompt.ask('What is your name?')
    return user_input
    # self.name = user_input
  end

  def get_user_password
    prompt = TTY::Prompt.new
    user_input = prompt.mask('Enter a password')
    return user_input
  end

  # Enter your gender
  def get_user_gender
    prompt = TTY::Prompt.new
    user_input = prompt.select("What's your gender?", %w(Female Male Others))
    user_input = 'male' if user_input == 'Others'
    return user_input.downcase
  end

# Enter your age
  def get_user_age
    print "Please input your age: "
    user_input = STDIN.gets.chomp.to_i
  end

# Enter your height
  def get_user_height
    print "Please input your height in cm: "
    user_input = STDIN.gets.chomp.to_i
  end

# Enter your weight
  def get_user_weight
    print "Please input your weight in kg: "
    user_input = STDIN.gets.chomp.to_i
  end

  def get_diet_type
    prompt = TTY::Prompt.new
    user_input = prompt.select("What do you hope to achieve with your diet?", %w(Gain\ weight Maintain\ weight Loose\ weight))
    return user_input.downcase
  end

  def get_activity_level
    prompt = TTY::Prompt.new
    choices = %w(Walking\ (min\ 10k\ steps) Runing\ and\ cycling Gym Swimming Yoga Other\sports)
    user_input = prompt.multi_select("What type of workout do you do?", choices)
    return user_input
  end

  def get_work_out_intensity
    prompt = TTY::Prompt.new
    user_input = prompt.select("How often do you work out?", %w(Never 1-2\ times\ a\ week 3-4\ times\ a\ week Over\ 5\ times\ a\ week))
    return user_input.downcase
  end

# create new user, ask for info, save to table
  def self.register_new_user
    new_user = User.create
    new_user.name = new_user.get_user_name
    new_user.password = new_user.get_user_password
    system 'clear'
    header
    puts "Welcome to Nutrition+, #{new_user.name}!", ""
    puts "First, let us get to know a bit about you...".green
    puts "-------------------------------------------------------------"
    new_user.gender = new_user.get_user_gender
    new_user.age = new_user.get_user_age
    new_user.height = new_user.get_user_height
    new_user.weight = new_user.get_user_weight
    new_user.diet_type = new_user.get_diet_type
    new_user.activity_level = new_user.get_activity_level
    new_user.work_out_intensity = new_user.get_work_out_intensity
    new_user.calculate_store_bmr
    new_user.carbo_target =  new_user.calculate_store_carbo_target
    new_user.protein_target = new_user.calculate_store_protein_target
    new_user.fat_target = new_user.calculate_store_fat_target
    new_user.save
    return new_user
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
   while true
     user_input = get_user_crave(day_of_the_week, meal_type)
     recipes = get_top_recipes(user_input)
     break if recipes != [] || user_input == "SIMS"
     puts "#{user_input.capitalize} is apparently not EDIBLE! Try another food."
     sleep 3
   end

   if user_input!= "SIMS"
     print_top_x(user_input, recipes, 5)
     selected_num = get_user_select
     @recipe_id, @meal_name, ingredients = get_selected_recipes(selected_num, recipes)
     @new_meal = Meal.create(user_id: self.id, day_of_the_week: day_of_the_week, meal_type: meal_type, meal_name: @meal_name, recipe_id: @recipe_id)
     @new_meal.cooking(ingredients)
     return 'That was delicious!'
   else
     self.sims_life
     return 'SIMS'
   end
 end


  # automatic eating. yes creepy
  def sims_life
    #search through Meal class with user_id. For week_day and meal_type not exist, automatically populate
    #cook the meal afterwards
    week_day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    meal_type = ["Breakfast", "Lunch", "Dinner"]

    week_day.each do |week_day|
      meal_type.each do |meal_type|
        if Meal.where(user_id: self.id, day_of_the_week:week_day, meal_type:meal_type) == []
          random_recipe = {}
          random_recipe = get_recipe_bank.sample
          recipe_id = random_recipe[:recipe_id]
          meal_name = random_recipe[:recipe_name]
          ingredients = random_recipe[:ingredients]
          new_meal = Meal.create(user_id: self.id, day_of_the_week: week_day, meal_type: meal_type, meal_name: meal_name, recipe_id: recipe_id)
          new_meal.cooking(ingredients)
        end
      end
    end
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

  def calories_consumed(day)

    trash_can = []
    calories, carbo, fat, protein = 0, 0, 0, 0
    Meal.where(user_id: self.id, day_of_the_week: "#{day}").each do |meal|
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

    return my_summary
  end


  #final output in the form of a weekly table showing cals and macros
  def make_summary_table
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    table = TTY::Table.new ["Unit", "Monday","Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Weekly Actual", "Weekly Target", "Performance"],
      [
        ["Calories", "#{calories_consumed(days[0])[0].round}", "#{calories_consumed(days[1])[0].round}", "#{calories_consumed(days[2])[0].round}", "#{calories_consumed(days[3])[0].round}", "#{calories_consumed(days[4])[0].round}", "#{calories_consumed(days[5])[0].round}", "#{calories_consumed(days[6])[0].round}", "#{calories_consumed_this_week[0].round}", "#{(self.bmr * 7).round}", "#{self.cal_performance}"],
        ["Carbohydrate", "#{calories_consumed(days[0])[1].round}", "#{calories_consumed(days[1])[1].round}", "#{calories_consumed(days[2])[1].round}", "#{calories_consumed(days[3])[1].round}", "#{calories_consumed(days[4])[1].round}", "#{calories_consumed(days[5])[1].round}", "#{calories_consumed(days[6])[1].round}", "#{calories_consumed_this_week[1].round}", "#{(self.carbo_target * 7).round}", "#{self.carb_performance}"],
        ["Fat", "#{calories_consumed(days[0])[2].round}", "#{calories_consumed(days[1])[2].round}", "#{calories_consumed(days[2])[2].round}", "#{calories_consumed(days[3])[2].round}", "#{calories_consumed(days[4])[2].round}", "#{calories_consumed(days[5])[2].round}", "#{calories_consumed(days[6])[2].round}", "#{calories_consumed_this_week[2].round}", "#{(self.fat_target * 7).round}", "#{self.fat_performance}"],
        ["Protein", "#{calories_consumed(days[0])[3].round}", "#{calories_consumed(days[1])[3].round}", "#{calories_consumed(days[2])[3].round}", "#{calories_consumed(days[3])[3].round}", "#{calories_consumed(days[4])[3].round}", "#{calories_consumed(days[5])[3].round}", "#{calories_consumed(days[6])[3].round}", "#{calories_consumed_this_week[3].round}", "#{(self.protein_target * 7).round}", "#{self.protein_performance}"]
      ]
    puts table.render(:ascii)
    puts "", "Summary Report"
    puts "#{self.cal_performance_summary_report}"
    puts "#{self.give_meal_recommendations}"
    puts "+------------+------+-------+---------+--------+------+--------+------+-------------+-------------+"
  end

  # def macro_ratio_met(day)
  #   macro_total = "calories_consumed_#{day}"[1] + "calories_consumed_#{day}"[2] + "calories_consumed_#{day}"[3]
  #   #carbs
  #     if ("calories_consumed_#{day}"[1] / macro_total).between?(0.45, 0.55)
  #       return " 👏 😊 "
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) > (0.55)
  #       return "😈 👆"
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) < (0.45)
  #       return " 😬 👇 "
  #   end
  # end
  #
  # def carbs_ratio_met(day)
  #   macro_total = "calories_consumed_#{day}"[1] + "calories_consumed_#{day}"[2] + "calories_consumed_#{day}"[3]
  #   #carbs
  #     if ("calories_consumed_#{day}"[1] / macro_total).between?(0.45, 0.55)
  #       return " 👏 😊 "
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) > (0.55)
  #       return "😈 👆"
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) < (0.45)
  #       return " 😬 👇 "
  #   end
  # end
  #
  # def protein_ratio_met(day)
  #   macro_total = "calories_consumed_#{day}"[1] + "calories_consumed_#{day}"[2] + "calories_consumed_#{day}"[3]
  #   #carbs
  #     if ("calories_consumed_#{day}"[1] / macro_total).between?(0.10, 0.20)
  #       return " 👏 😊 "
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) > (0.20)
  #       return "😈 👆"
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) < (0.10)
  #       return " 😬 👇 "
  #   end
  # end
  #
  # def fat_ratio_met(day)
  #   macro_total = "calories_consumed_#{day}"[1] + "calories_consumed_#{day}"[2] + "calories_consumed_#{day}"[3]
  #   #carbs
  #     if ("calories_consumed_#{day}"[1] / macro_total).between?(30, 40)
  #       return " 👏 😊 "
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) > (40)
  #       return "😈 👆"
  #     elsif ("calories_consumed_#{day}"[1] / macro_total) < (30)
  #       return " 😬 👇 "
  #   end
  # end


  def give_meal_recommendations
    #find ratio
    total = self.calories_consumed_this_week[1] + self.calories_consumed_this_week[2] + self.calories_consumed_this_week[3]
    carb_ratio = self.calories_consumed_this_week[1] / total
    fat_ratio = self.calories_consumed_this_week[2] / total
    protein_ratio = self.calories_consumed_this_week[3] / total
    #find difference btween actual ratio and target ratio
    carbs_from_target = carb_ratio - 0.50
    fat_from_target = fat_ratio - 0.15
    protein_from_target = protein_ratio - 0.35
    #find macro with biggest difference
    winner = [carbs_from_target, fat_from_target, protein_from_target].max_by {|macro| macro.abs}
    #find whether that macro is pos or  negative
      if winner == protein_from_target && winner < 0
        puts "Your protein ratio for this week was too low.\nWhy don't you try Beer-Marinated Flank Steak with Aji and Guacamole next week!"
      elsif winner == protein_from_target && winner >= 0
        puts "Your protein ratio for this week was too high.\nWhy don't you try a Vegan Caesar Salad next week!"
      elsif winner == fat_from_target && winner < 0
        puts "Your fat ratio for this week was too low.\nWhy don't you try a Baileys and chocolate cheesecake next week!"
      elsif winner == fat_from_target && winner >= 0
        puts "Your fat ratio for this week was too high.\nWhy don't you try an Asparagus Salad with Shrimp next week!"
      elsif winner == carbs_from_target && winner < 0
        puts "Your carbohydrate ratio for this week was too low.\nWhy don't you try our Winter Pasta recipie next week!"
      elsif winner == carbs_from_target && winner >= 0
        puts "Your carbohydrate intake this week was too high.\nWhy don't you try Bacon Wrapped Jalapeno Popper Stuffed Chicken next week!"
      end
    end

    def cal_performance
       if calories_consumed_this_week[0].round > (self.bmr * 7).round
         "😬 👇"
       elsif calories_consumed_this_week[0].round < (self.bmr * 7).round
         "😃 👆"
       end
     end

     def cal_performance_summary_report
        if calories_consumed_this_week[0].round > (self.bmr * 7 * 1.1).round
          "Your overall calorie intake is too high (eat less, cough cough!)"
        elsif calories_consumed_this_week[0].round < (self.bmr * 7 * 0.9).round
          "Your overall calorie intake is too low (feel free to have more desert!)"
        else
          "Well done for following your meal plan. Keep it up!"
        end
      end

    def carb_performance
      if calories_consumed_this_week[1].round > (self.carbo_target * 7).round
        "😬 👇"
       elsif calories_consumed_this_week[1].round < (self.carbo_target * 7).round
        "😃 👆"
      end
    end

    def fat_performance
      if calories_consumed_this_week[2].round > (self.fat_target * 7).round.round
        "😬 👇"
      elsif calories_consumed_this_week[2].round < (self.fat_target * 7).round.round
        "😃 👆"
      end
    end

    def protein_performance
      if calories_consumed_this_week[3].round > (self.protein_target * 7).round
        "😬 👇"
      elsif calories_consumed_this_week[3].round < (self.protein_target * 7).round
        "😃 👆"
      end
    end

    def get_weekly_nutritional_target
       calories, carbo, fat, protein = self.bmr * 7, self.carbo_target * 7, self.fat_target * 7, self.protein_target * 7
    end

    def meal_on_day_x(day_of_the_week,meal_type)
      meal = Meal.where(day_of_the_week:day_of_the_week,meal_type:meal_type,user_id:self.id)[0]
      return meal.meal_name
    end
end

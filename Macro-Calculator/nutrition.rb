require 'pry'

class User

  attr_accessor :gender, :age, :height, :weight, :protein, :carbohydrates, :fat
  attr_reader :bmr, :wk_macro_target

  @@all = []

  def initialize
    @gender
    @age
    @height
    @weight
  end

  def self.all
    @@all
  end

# Enter your gender
def get_user_gender
  puts "Please input your gender (Male/Female):"
  user_input = gets.chomp
  :gender = user_input
end

# Enter your age
def get_user_age
  puts "Please input your age:"
  user_input = gets.chomp.to_i
  :age = user_input
end

# Enter your height
def get_user_height
  puts "Please input your height in cm:"
  user_input = gets.chomp.to_i
  :height = user_input
end

# Enter your weight
def get_user_weight
  puts "Please input your weight in kg:"
  user_input = gets.chomp.to_i
  :weight = user_input
end


def calculate_bmr
  get_user_gender
# BMR Male
# (10 × weight in kg) + (6.25 × height in cm) - (5 × age in years) + 5
  if "Male"
    user_bmr = (10 * get_user_weight) + (6.25 * get_user_height) - (5 * get_user_age) + 5
# BMR Female
# (10 × weight in kg) + (6.25 × height in cm) - (5 × age in years) - 161
  elsif "Female"
    user_bmr = (10 * get_user_weight) + (6.25 * get_user_height) - (5 * get_user_age) - 161
  end
  :bmr = user_bmr
end

# Compare calories from weekly meal plan to bmr * 7 days
def set_weekly_target(my_bmr, my_weekly_calories)
  # weekly_meal_plan_calories
  # my_bmr * 7
  if weekly_meal_plan_calories < (my_bmr * 7)
    puts "You are on track to loose weight"
  elsif weekly_meal_plan_calories > (my_bmr * 7)
    puts "You will gain weight"
  elsif weekly_meal_plan_calories == (my_bmr * 7) #add error +-
    puts "You have met your weekly target"
end

def carb_target
  @carbohydrates = (@bmr * 0.5) / 4
end

def protein_target
  @protein = (@bmr * 0.15) / 4
end

def fat_target
  @fat= (@bmr * 0.35) / 4
end

def macros_per_week

end

end


binding.pry

p "0"

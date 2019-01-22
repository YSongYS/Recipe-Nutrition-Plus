class User < ActiveRecord::Base

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

  # calculate macro targets

  def calculate_store_carb_target
    self.carbo_target = (self.bmr * 0.5) / 4
  end

  def calculate_store_protein_target
    self.protein = (self.bmr * 0.15) / 4
  end

  def calculate_store_fat_target
    self.fat = (self.bmr * 0.35) / 9
  end

# calculate weekly calories though meals
# taking nutrition info from ingredients






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
    new_user = User.new
    new_user.name = new_user.get_user_name
    new_user.gender = new_user.get_user_gender
    new_user.age = new_user.get_user_age
    new_user.height = new_user.get_user_height
    new_user.weight = new_user.get_user_weight
    new_user.calculate_store_bmr
  end

end

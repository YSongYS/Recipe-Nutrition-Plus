
def welcome_to_app
  puts "Welcome to Recipe Nutrition+!"
end

def slowprint (array)
  array.each do |word|
    print "#{word} ".green
    sleep 0.25
  end
  print "\n"
end

def register_app
  sleep 1.5
  puts "", ""
  puts "First, let us get to know a bit about you...".green
  puts "-------------------------------------------------------------"
  sleep 1
  new_user = User.register_new_user

  slowprint("... ... ... computing your nutritional targets ... ... ... ".split(" "))

  puts "",""
  puts "Based on your profile, we suggest weekly nutritional targets of:".green
  puts "-------------------------------------------------------------"
  calories, carbo, fat, protein = new_user.get_weekly_nutritional_target
  puts "Calories: #{calories.round}"
  printf "%20s %s\n", "Carbohydrates:", "#{carbo.round}"
  printf "%20s %s\n", "Fat:", "#{fat.round}"
  printf "%20s %s\n", "Protein:", "#{protein.round}"
  #puts "   Carbohydrates: #{carbo.round}"
  #puts "   Fat: #{fat.round}"
  #puts "   Protein: #{protein.round}"
  puts "-------------------------------------------------------------"
  sleep 3
  puts "", "Probably doesn't mean much to you right? :) That's why the app is here to help!"
  puts "Let's started on your week!"
  sleep 1.5
end

def week_day_time_machine
  puts ""
  print "Loggin in: ".green
  user_input = gets.chomp
  user = User.find_by(name:user_input)

  week_day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  meal_type = ["Breakfast", "Lunch", "Dinner"]
  week_day.each do |week_day|
    break unless meal_type.each do |meal_type|
      puts "-------------------------------------------------------------"
      feedback = user.eating(week_day, meal_type)
      if feedback == "SIMS"
        puts ""
        slowprint "🐵 .. 🙈 .. 🙉 .. 🙉 .. 🐵 .. 🙈 .. 🙉 .. 🙉".split(" ")
        puts "Woo... A whole week passed by so quickly...".green
        break
      end
      puts feedback
      puts ""

    end
  # put a daily summary print out here.
  puts "DAILY SUMMARY PLACE HOLDER"
  end
end

def weekly_summary_time
  sleep 1.5
  puts  ""
  puts "-------------------------------------------------------------"
  puts "Let's take a look at your result this week!"
  puts "TABLE PLACEHOLDER", "", ""
end

require_relative '../../config/environment'

def header
  puts "", "", "", "", "", ""
  artii = Artii::Base.new
  puts artii.asciify('Recipe Nutrition +')
end

def good_bye
  system 'clear'
  header
  puts "Thanks for using Nutrition+. Good bye!"
end

def new_or_old_user
  prompt = TTY::Prompt.new
  prompt.select("New to Nutrition+?", %w(Sign\ up Log\ in))
end

def welcome_to_app
  puts "Welcome to Recipe  Nutrition+!"
end

def slowprint (array)
  array.each do |word|
    print "#{word} ".green
    sleep 0.25
  end
  print "\n"
end

def register_app
  system 'clear'
  header
  #sleep 1.5
  puts "", ""
  sleep 1
  new_user = User.register_new_user

  system 'clear'
  header
  puts "","","","","","","",""
  slowprint("... ... ... computing your nutritional targets ... ... ... ".split(" "))

  system 'clear'
  header
  puts "",""
  puts "Based on your profile, we suggest weekly nutritional targets of:".green
  puts ""
  calories, carbo, fat, protein = new_user.get_weekly_nutritional_target
  table = TTY::Table.new ['Nutrition item','Target amount'], [['Calories', "#{calories.round}"],['Carbohydrates', "#{carbo.round}"], ['Fat', "#{fat.round}"], ['Protein', "#{protein.round}"]]
  puts table.render(:ascii)
  #puts "Calories: #{calories.round}"
  #printf "%20s %s\n", "Carbohydrates:", "#{carbo.round}"
  #printf "%20s %s\n", "Fat:", "#{fat.round}"
  #printf "%20s %s\n", "Protein:", "#{protein.round}"
  #puts "   Carbohydrates: #{carbo.round}"
  #puts "   Fat: #{fat.round}"
  #puts "   Protein: #{protein.round}"
  puts "-------------------------------------------------------------"
  sleep 3
  puts "", "Probably doesn't mean much to you right? :) That's why the app is here to help!"
  puts "Let's get started on your week!"

  puts "", ""

  prompt = TTY::Prompt.new
  answer = prompt.select("Let's get started on your week!", %w(Yes No))
  if answer == "No"
    puts "let's pretend you said yes and continue"
    sleep 3
  end

end

def week_day_time_machine
  system 'clear'
  header
  puts "",""

  while true do
    prompt = TTY::Prompt.new
    puts "Let's log you in.. "
    user_input = prompt.ask('Name:')
    user_input2 = prompt.mask('Password:')
    user = User.find_by(name:user_input)
    password = user.password if user != nil

    break if user != [] && user_input2 == password

    puts "", "",'Oops, no such user or wrong password 🙉'
    answer = prompt.select("What would you like to do?", %w(Try\ again Go\ back))

    if answer == "Go back"
      register_app
      break
    end

    system 'clear'
    header

  end

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
  return user
end

def weekly_summary_time(user)
  sleep 1.5
  puts  ""
  puts "-------------------------------------------------------------"
  puts "Let's take a look at your result this week!"
  user.make_summary_table
end

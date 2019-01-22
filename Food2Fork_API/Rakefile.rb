require_relative './config/environment'
require 'sinatra/activerecord/rake'

# Type `rake -T` on your command line to see the available rake tasks.

task :console do
  Pry.start
end


# get user info and save to user table
namespace :get_user_info do
  desc "ask user for info, update user table"
  task :get_info do
    User.register_new_user
  end
end

require 'bundler/setup'
Bundler.require

require 'active_record'
require 'rake'

require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

require 'csv'
require 'colorize'


require_all 'app'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/development.sqlite"
)

#ActiveRecord::Base.logger.level = 1

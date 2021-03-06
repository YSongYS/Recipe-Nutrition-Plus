# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_25_100030) do

  create_table "cookings", force: :cascade do |t|
    t.integer "meal_id"
    t.integer "ingredient_id"
    t.float "usage"
    t.string "common_unit"
    t.string "unit_v_or_w"
    t.float "weight_in_g"
    t.float "volume_in_cup"
    t.string "ingredient_na"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "ingredient_long_name"
    t.string "ingredient_name"
    t.string "common_unit_volume"
    t.float "equivalent_volume_cup"
    t.float "equivalent_weight_g"
    t.float "calories_kCal"
    t.float "fat_g"
    t.float "carbo_g"
    t.float "protein_g"
    t.string "unit_v_or_w"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "user_id"
    t.string "day_of_the_week"
    t.string "meal_type"
    t.string "meal_name"
    t.integer "recipe_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.float "age"
    t.float "height"
    t.float "weight"
    t.float "bmr"
    t.float "carbo_target"
    t.float "protein_target"
    t.float "fat_target"
    t.string "password"
    t.string "diet_type"
    t.string "activity_level"
    t.string "work_out_intensity"
  end

end

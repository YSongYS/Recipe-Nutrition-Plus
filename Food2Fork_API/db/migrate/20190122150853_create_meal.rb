class CreateMeal < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.integer :user_id
      t.integer :cooking_id
      t.string :day_of_the_week
      t.string :meal_type
      t.string :meal_name
      t.integer :recipe_id ## recipe_id from food2fork
    end
  end
end

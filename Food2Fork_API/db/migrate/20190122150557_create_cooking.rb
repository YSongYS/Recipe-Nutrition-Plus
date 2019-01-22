class CreateCooking < ActiveRecord::Migration[5.2]
  def change
    create_table :cookings do |t|
      t.integer :meal_id
      t.integer :ingredient_id
      t.float :usage
      t.string :unit
      t.string :unit_v_or_w
    end
  end
end

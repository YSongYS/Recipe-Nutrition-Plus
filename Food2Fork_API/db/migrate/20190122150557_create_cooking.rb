class CreateCooking < ActiveRecord::Migration[5.2]
  def change
    create_table :cookings do |t|
      t.integer :meal_id
      t.integer :ingredient_id
      t.float :usage
      t.string :common_unit
      t.string :unit_v_or_w
      t.float :weight_in_g
      t.float :volume_in_cup
    end
  end
end

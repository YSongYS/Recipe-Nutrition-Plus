class CreateIngredients < ActiveRecord::Migration[4.2]
  def change
    create_table :ingredients do |t|
      t.string :ingredient_long_name
      t.string :ingredient_name
      t.string :common_unit_volume
      t.float :equivalent_volume_cup
      t.float :equivalent_weight_g
      t.float :calories_kCal
      t.float :fat_g
      t.float :carbo_g
      t.float :protein_g
      t.string :unit_v_or_w
    end
  end
end

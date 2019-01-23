class AddColumnIngredientNaToCooking < ActiveRecord::Migration[5.2]
  def change
    add_column :cookings, :ingredient_na, :string 
  end
end

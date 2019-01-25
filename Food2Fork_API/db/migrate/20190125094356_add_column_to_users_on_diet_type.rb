class AddColumnToUsersOnDietType < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :diet_type, :string
  end
end

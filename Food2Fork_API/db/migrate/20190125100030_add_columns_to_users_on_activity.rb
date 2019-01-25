class AddColumnsToUsersOnActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activity_level, :string
    add_column :users, :work_out_intensity, :string
  end
end

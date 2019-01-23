class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :gender
      t.float :age
      t.float :height
      t.float :weight
      t.float :bmr
      t.float :carbo_target
      t.float :protein_target
      t.float :fat_target
    end
  end
end

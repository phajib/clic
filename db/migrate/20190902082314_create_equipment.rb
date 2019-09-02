class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :camera
      t.string :lens
      t.string :speedlight
      t.string :drone
      t.string :accessories
      t.integer :user_id
      t.integer :log_id

      t.timestamps null: false
    end
  end
end

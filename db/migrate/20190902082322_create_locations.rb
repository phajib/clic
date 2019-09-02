class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :place
      t.string :city
      t.string :country
      t.integer :log_id

      t.timestamps null: false
    end
  end
end

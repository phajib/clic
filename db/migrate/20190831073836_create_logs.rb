class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :shoot_title
      t.datetime :shoot_date
      t.string :place
      t.string :city
      t.string :country
      t.string :camera
      t.string :lens
      t.string :speedlight
      t.string :drone
      t.string :accessories
      t.text :notes
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end

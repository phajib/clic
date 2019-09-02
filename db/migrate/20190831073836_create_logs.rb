class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :shoot_title
      t.datetime :shoot_date
      t.string :notes

      t.timestamps null: false
    end
  end
end

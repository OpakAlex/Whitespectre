class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string :title, null: false
      t.text :body, default: ""
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.float :longitude
      t.float :latitude
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end

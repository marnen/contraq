class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.string :name, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :venue
      t.string :street
      t.string :city
      t.string :state, limit: 2
      t.string :zip

      t.timestamps null: false
    end
  end
end

class AddUserIdToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :user_id, :integer
    add_foreign_key :gigs, :users
  end
end

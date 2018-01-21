class AddPaymentTermsToGigs < ActiveRecord::Migration[5.1]
  def change
    add_column :gigs, :amount_due, :decimal, precision: 8, scale: 2
    add_column :gigs, :terms, :integer, limit: 2
  end
end

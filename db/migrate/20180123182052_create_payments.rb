class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :gig, foreign_key: true, null: false
      t.date :received_at
      t.decimal :amount, precision: 8, scale: 2
      t.timestamps
    end
  end
end

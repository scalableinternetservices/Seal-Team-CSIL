class CreateProviders < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :food_type
      t.string :location
      t.string :phone_number
      t.string :hours
      t.string :delivery
      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :food_type
      t.string :address
      t.string :phone_number
      t.string :hours
      t.string :delivery
      t.float  :latitude
      t.float  :longitude
      t.timestamps null: false
    end
  end
end

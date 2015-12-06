class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :food_type
      t.string :address
      t.string :phone_number
      t.timestamps null: false
    end
  end
end

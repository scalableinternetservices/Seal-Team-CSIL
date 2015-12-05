class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.belongs_to :user
      t.string   :food_name
      t.string   :address
      t.string   :deal_type
      t.datetime :start_time
      t.datetime :end_time
      t.string   :food_type
      t.float    :latitude
      t.float    :longitude
      t.timestamps null: false
    end
  end
end

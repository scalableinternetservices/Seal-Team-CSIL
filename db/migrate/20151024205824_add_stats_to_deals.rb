class AddStatsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :views, :integer
    add_column :deals, :shares, :integer
    add_column :deals, :purchases, :integer
  end
end

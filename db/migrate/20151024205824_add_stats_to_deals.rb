class AddStatsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :views, :integer, default: 0
    add_column :deals, :shares, :integer, default: 0
    add_column :deals, :purchases, :integer, default: 0
  end
end

class AddStatsToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :views, :integer, default: 0
  end
end

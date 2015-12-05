class AddSqlIndexing < ActiveRecord::Migration
  def change
    add_index :deals, :latitude 
    add_index :deals, :longitude
  end
end

class CreateWatchlistTypes < ActiveRecord::Migration
  def self.up
    create_table :watchlist_types do |t|
      t.column :name, :string
      t.column :description, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :watchlist_types
  end
end

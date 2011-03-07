class CreateWatchlists < ActiveRecord::Migration
  def self.up
    create_table :watchlists do |t|
      t.column :term, :string
      t.column :email_notify, :boolean, :default => false
      t.column :user_id, :integer
      t.column :watchlist_type_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :watchlists
  end
end

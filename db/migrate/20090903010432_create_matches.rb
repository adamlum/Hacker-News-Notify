class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.column :post_title, :string
      t.column :post_by, :string
      t.column :post_url, :string
      t.column :post_number, :string
      t.column :watchlist_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end

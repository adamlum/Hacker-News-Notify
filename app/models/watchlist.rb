class Watchlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :watchlist_type
  has_many :matches, :order => "created_at DESC"
end

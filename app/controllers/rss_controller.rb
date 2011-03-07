class RssController < ApplicationController
  layout false

  def index
    username = params[:u]
    v = params[:v]
    @rss_user = User.find(:first, :conditions => [ "username = ? AND single_access_token = ?", username, v ])
    watchlists = Watchlist.find(:all, :conditions => ["user_id = ?", @rss_user.id])
    watchlist_ids = []
    watchlists.each do |w|
      watchlist_ids << w.id
    end
    @matches = Match.find(:all, :conditions => {:watchlist_id => watchlist_ids},  :order => "created_at DESC")
    response.headers["Content-Type"] = "application/rss+xml"
  end

end

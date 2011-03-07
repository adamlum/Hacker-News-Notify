class WatchlistController < ApplicationController
  protect_from_forgery :only => [:add, :delete]

  def index
    if !current_user
      redirect_to(login_path)
      return
    end
    @subtitle = "Watchlist"
    @rsslink = "/rss?u=" + current_user.username + "&v=" + current_user.single_access_token
    @watchlists = Watchlist.find(:all, :conditions => ["user_id = ?", current_user])
  end
	
  def add
    if !current_user
      redirect_to(login_path)
      return
    end
    if params[:watchfor]
      watchlist_item = Watchlist.new
      watchlist_item.term = params[:watchfor]
      watchlist_item.created_at = DateTime.now
      watchlist_item.user_id = current_user.id
      if params[:watchtype] == "thread"
        watchlist_item.watchlist_type_id = 4
      elsif params[:watchtype] == "domain"
        watchlist_item.watchlist_type_id = 3
      elsif params[:watchtype] == "user"
        watchlist_item.watchlist_type_id = 2
      else
        watchlist_item.watchlist_type_id = 1
      end
      if watchlist_item.save
        flash[:notice] = "Your new watchlist item was created successfully!"
      end
    end
    redirect_to("/watchlist")
  end
	
  def delete
    if !current_user
      redirect_to(login_path)
      return
    end
    temp_wl = Watchlist.find(:all, :conditions => ["id = ? AND user_id = ?", params[:w], current_user])
    if !temp_wl.empty?
      matches = Match.find(:all, :conditions => ["watchlist_id = ?", temp_wl.id])
      matches.each do |match|
        Match.destroy(match.id)
      end
      Watchlist.destroy(params[:w])
    end
    redirect_to("/watchlist")
  end

  def toggle_notification
    if !current_user
      redirect_to(login_path)
      return
    end
    temp_wl = Watchlist.find(:first, :conditions => ["id = ? AND user_id = ?", params[:w], current_user])
    if temp_wl
      if current_user.email_validated
        if temp_wl.email_notify
          temp_wl.email_notify = false
        else
          temp_wl.email_notify = true
        end
        temp_wl.save
      end
    end
    redirect_to("/watchlist")
  end
end

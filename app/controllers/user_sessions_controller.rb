class UserSessionsController < ApplicationController
  def new
    @subtitle = "Login"
    @user_session = UserSession.new
  end
  
  def create
    @subtitle = "Sign Up"
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to("/watchlist")
    else
      flash[:notice] = "Invalid username or password."
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end

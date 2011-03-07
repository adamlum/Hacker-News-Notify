class UsersController < ApplicationController
  def new
    @user = User.new
    @subtitle = "Sign Up"
  end
  
  def create
    @user = User.new(params[:user])
    if !verify_recaptcha
      flash[:notice] = "Invalid reCaptcha entry, please try again."
      render :action => 'new'
      return
    end
    if @user.email.strip.length > 0
      @user.email_validation_code = @user.generate_email_validation_string(12)
    end
    if @user.save
      if @user.email.strip.length > 0
        Emailer.deliver_validation_email(@user.email.strip, @user.username, @user.email_validation_code)
      end
      flash[:notice] = "Successfully registered."
      redirect_to("/watchlist") 
    else
      render :action => 'new'
    end
  end
  
  def edit
    if !current_user
      redirect_to login_path
    end
    @user = current_user
    @subtitle = "Edit User Profile"
  end
  
  def update
    @user = current_user
    confirmation_string = ""
    if params[:user]["email"].strip.length > 0 && params[:user]["email"].strip != @user.email
      @user.email_validation_code = @user.generate_email_validation_string(12)
      @user.email_validated = false
      @user.save
      Watchlist.find(:all, :conditions => ["user_id = ?", current_user]).each do |w|
        w.email_notify = false
        w.save
      end
      Emailer.deliver_validation_email(params[:user]["email"].strip, @user.username, @user.email_validation_code)
      confirmation_string += " Email validation message sent."
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated." + confirmation_string
      redirect_to("/watchlist")
    else
      render :action => 'edit'
    end
  end
end

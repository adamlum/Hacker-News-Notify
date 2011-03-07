class ValidateController < ApplicationController
  def index()
    if !params[:u] && !params[:v]
      flash[:notice] = "Invalid email validation credentials."
      redirect_to root_url
      return
    end
    validated_user = User.find(:first, :conditions => [ "username = ? AND email_validation_code = ?", params[:u], params[:v] ])
    if validated_user
      validated_user.email_validated = true
      validated_user.email_validation_code = validated_user.generate_email_validation_string(20)
      validated_user.save
      flash[:notice] = "Email validated successfully."
      redirect_to("/watchlist")
    else
      flash[:notice] = "Invalid email validation credentials."
      redirect_to root_url
    end
  end
end

class SessionsController < ApplicationController
  def new
  end
  
  def create
   user = User.find_by(email: params[:session][:email].downcase)
   if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember user
      redirect_to user
      # This is to log the user in and redirect to the user's show page
    else
      # error message
    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
  end
end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

class SessionsController < ApplicationController
  ssl_required if ENV['RAILS_ENV'] == "production"
    
  def show
    new
    render :action => :new, :layout => false
  end

  def new
    render :layout => false
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user.nil?
		  flash[:error] = "Oops! Invalid email/password combination"
		  render :action => 'new', :layout => false
	  else
	    current_user = @user
	    current_user.remember_me
      cookies[:auth_token] = {
        :value   => current_user.remember_token,
        :expires => current_user.remember_token_expires_at }
      redirect_to admin_dashboard_path		
		end
  end

  def destroy
    current_user.forget_me if current_user
    cookies.delete :auth_token
    session[:user] = nil
    reset_session
	  flash[:notice]= "You are now logged out."
	  redirect_to new_session_path
  end

  
end

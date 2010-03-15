module Authentication
  protected
  
  # Inclusion hook to make #current_user and #logged_in?
  # available as ActionView helper methods.
  def self.included(base)
    base.send :helper_method, :current_user
  end

  def current_user
    @current_user ||= (login_from_session || login_from_cookie || nil)
  end

  def current_user=(new_user)
    session[:user_id] = new_user.nil? ? nil : new_user.id
    @current_user = new_user
  end
  
  # Called from #current_user.  First attempt to login by the person id stored in the session.
  def login_from_session
    self.current_user = User.find(session[:user_id]) if session[:user_id]
  end

  # Called from #current_user.  Finally, attempt to login by an expiring token in the cookie.
  def login_from_cookie
    user = cookies[:auth_token].blank? ? nil : User.find_by_remember_token(cookies[:auth_token])
    if user and user.remember_token?
      user.remember_me
      cookies[:auth_token] = { :value => user.remember_token, :expires => user.remember_token_expires_at }
      self.current_user = user
    end
  end
  
end
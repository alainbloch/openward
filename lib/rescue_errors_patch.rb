module ActionController::Rescue
  
  # Lets have some dynamic error pages instead of static ones
  def render_optional_error_file(status_code)
    case status_code
    when :not_found : redirect_to error_path(404)
    when :internal_server_error : redirect_to error_path(500)
    else
      super
    end
  end
  
end
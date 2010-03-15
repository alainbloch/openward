class ErrorsController < ApplicationController
  
  def show
    status_code = params[:id].to_i
    case status_code
    when 404 : render :template => "/errors/404"
    when 500 : render :template => "/errors/500"
    else
      render :nothing => true, :status => status_code
    end
  end
  
end

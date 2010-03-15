class ConnectController < ApplicationController
  
  def show
    new
  end
  
  def new
    @suggestion = Suggestion.new
    @page_title =  %(People and Place: Make a Connection)
    render :action => 'show'
  end
  
  def create
    @suggestion = Suggestion.new(params[:suggestion])
    @page_title =  %(People and Place: Make a Connection)
    render :update do |page|
      if @suggestion.save_with_captcha
        title = "Connection Added"
        comment = "Thank you! Your connection has been sent!"
        @suggestion = Suggestion.new
        page.replace "connection_form", :partial => "form"
      else
        title = "Connection Error"
        comment = error_messages_for(:suggestion)
      end
      page.replace_html "alert_popup-content", :partial => "shared/alert", :locals => {:title => title, :comment => comment}
    end
  end
  
end

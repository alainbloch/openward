class SubscribeController < ApplicationController
  
  def show
    @subscription = Subscription.new
    @page_title =  %(People and Place: Subscribe to P&P)
  end
  
  def create
    @subscription = Subscription.new(params[:subscription])
    @page_title =  %(People and Place: Subscribe to P&P)
    render :update do |page|
      if @subscription.save #_with_captcha
        title = "Subscription Added"
        comment = "Your subscription has been added."
        @subscription = Subscription.new
        page.replace "subscribe_form", :partial => "form"
      else
        title = "Subscription Error"
        comment = error_messages_for(:subscription)
      end
      page.replace_html "alert_popup-content", :partial => "shared/alert", :locals => {:title => title, :comment => comment}
    end
  end
  
end

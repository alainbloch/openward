class Admin::AdminController < ApplicationController
  ssl_required if ENV['RAILS_ENV'] == "production"
  
  layout "admin"
  
  before_filter :admin_item
  
  permit "admin or contributor", :except => [:preview]
  
  helper "admin"
  
  def show
    redirect_to admin_dashboard_path
  end

private

  def xmlrpc_ping
    PING_SERVICES.each do |service|
      begin
        server = XMLRPC::Client.new2(service)
        server.call2('weblogUpdates.ping',PING_BLOG_NAME,PING_BLOG_URL)
      rescue => detail
        logger.info("ping failed for server #{service} (#{detail})")
      end
    end unless ENV['RAILS_ENV'] == "test" or ENV['RAILS_ENV'] == "development"
  end

protected
  
  def admin_item
    @admin_item = true
  end
  
end

class ProtectController < ApplicationController
  #skip_before_filter :authenticate
      
    def index
      @user_ip = request.env['REMOTE_ADDR']
      logger.info "Users IP: #{@user_ip}"
      render :layout => false
    end

end

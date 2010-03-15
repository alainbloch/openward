class Admin::SettingsController < Admin::AdminController
  
  permit "admin"
  
  def show
    @setting = Setting.find(:first)
  end
  
  def update
    @setting = Setting.find(:first)
    if @setting.update_attributes(params[:setting])
      flash[:notice] = "The settings have been saved."
    else
      flash[:error]  = "An error has occurred."
    end
    redirect_to admin_settings_path
  end
  
end

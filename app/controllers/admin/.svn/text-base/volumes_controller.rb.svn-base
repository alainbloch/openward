class Admin::VolumesController < Admin::AdminController
  
  permit "admin"
  
  def index
    @volume  = Volume.new(:title => "Title of Volume Goes Here")
    @volumes = Volume.find(:all, :order => "created_at DESC")
  end
  
  def new
    
  end
  
  def create
    @volume = Volume.new(params[:volume])
    @volume.number = Volume.next_volume_number
    respond_to do |wants|
      if @volume.save
        wants.html do
          flash[:message] = "Volume #{@volume.number} has been created."
          redirect_to admin_volumes_path
        end
        wants.js do
          render :update do |page|
            page.insert_html :top, "volumes", :partial => "/admin/volumes/volume", :locals => {:volume => @volume}
            page << "alert('Volume #{@volume.number} has been created.')"
          end          
        end
      else
        wants.html do
          flash[:error] = "An error has occurred."
          redirect_to admin_volumes_path
        end
        wants.js do
          render :update do |page|
            page << "alert('An error has occurred.')"
          end
        end
      end
    end
  end
  
  def edit
    @volume = Volume.find_by_id(params[:id])
    respond_to do |wants|
      wants.js do
        render :update do |page|
          page.replace "volume_#{@volume.id}", :partial => "/admin/volumes/edit_volume", :locals => {:volume => @volume}
        end
      end
    end
  end

  def update
    @volume = Volume.find_by_id(params[:id])
    #@volume.attributes = params[:volume] unless params[:cancel]
    respond_to do |wants|
      wants.js do
        if @volume.update_attribute(:title, params[:title])
          render :update do |page|
            page.replace "volume_#{@volume.id}", :partial => "/admin/volumes/volume", :locals => {:volume => @volume}
            page << "alert('Volume #{@volume.number} has been updated.')"
          end
        else
          render :update do |page|
            page << "alert('An error has occurred.')"
          end
        end  
      end
    end
  end
  
  def activate
    volume = Volume.find_by_id(params[:active_volume])
    respond_to do |format|
      format.html do
        if volume.make_active(:issue => params[:active_issue])
          flash[:message] = "Volume #{volume.number}, Issue #{volume.active_issue.number} has been made active"
        else
          flash[:error]   = "An error has occurred and your changes have not been saved"
        end
        redirect_to admin_volumes_path
      end
    end
  end

  def destroy
    @volume = Volume.find_by_id(params[:id])
    if @volume.destroy
      redirect_to admin_volumes_path
    else
      redirect_to :back
    end
  end
  
end

class Admin::MediasController < Admin::AdminController
  
  helper "media_library"

  def index
    @column = params[:column] || "updated_at"
    @order  = params[:order] || "DESC"
    if current_user.has_role? "admin"
      @medias = Media.paginate(:page => params[:page], :order => "#{@column} #{@order}")
    elsif current_user.has_role? "contributor"
      @medias = current_user.medias.paginate(:page => params[:page], :per_page => 10, :order => "#{@column} #{@order}")
    end
  end
  
  def show
    edit
    render :action => "edit"
  end
  
  def new
    @media = Media.new
  end
  
  def preview
    @media = Media.find_by_id(params[:id])
    @page_title =  %(#{@media.title} | P&P) if @media
    render :template => "/media_library/show", :layout => "ecotrust"
  end
  
  def create
    @media = Media.new(params[:media])
    if current_user.has_role? "admin"
      update_protected
    else
      @media.created_at = DateTime.now
      @media.user = current_user
    end
    if @media.save
      Activity.create(:action => @media, :description => "was created by #{current_user.name}", :user => current_user)
      @media.accepts_role('owner', @media.user)
      case params[:commit]
      when "Save and Preview"
        redirect_to preview_admin_media_path(@media)
      when "Save and Continue Editing"
        flash[:notice] = 'The media was successfully created.'
        redirect_to edit_admin_media_path(@media)
      when "Save"
        flash[:notice] = 'The media was successfully created.'
        redirect_to admin_medias_path
      when "Send to Editor"
        #need to add some code here to send some sort of message to the editor
        redirect_to admin_medias_path        
      end
    else
      flash[:notice] = 'An error has occurred.'
      render :action => "new"
    end
  end
  
  def edit
    @media = Media.find_by_id(params[:id])
    permit "admin or owner of :media"
    if @media.nil? 
      flash[:notice] = 'The page was not found.'
      redirect_to admin_medias_path
    end
  end
  
  def update
    @media = Media.find(params[:id])
    permit "admin or owner of :media"
    update_protected if current_user.has_role? "admin"
    if @media.update_attributes(params[:media])
      Activity.create(:action => @media, :description => "was updated by #{current_user.name}", :user => current_user)
      case params[:commit]
      when "Save and Preview"
        redirect_to preview_admin_media_path(@media)
      when "Save and Continue Editing"
        flash[:notice] = "The media has been updated."
        redirect_to edit_admin_media_path(@media)
      when "Save"
        flash[:notice] = "The media has been updated."
        redirect_to admin_medias_path
      when "Send to Editor"
        #need to add some code here to send some sort of message to the editor
        redirect_to admin_medias_path        
      end
    else
      flash[:notice] = 'An error has occurred.'
      render :action => "edit"
    end
  end
  
  def archive
    @media = Media.find_by_id(params[:id])
    permit "admin or owner of :media"
    @media.update_attribute(:in_archive, params[:in_archive])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @media.in_archive
            page << "alert('Media is now in archive.');"
          else
            page << "alert('Media has been removed from archive.');"            
          end
        end
      end
    end
  end
  
  def destroy
    @media = Media.find_by_id(params[:id])
    permit "admin or owner of :media"
    if @media.destroy
      Activity.create(:action => @post, :description => "was deleted by #{current_user.name}", :user => current_user)      
    end
    redirect_to admin_medias_path
  end
  
  def caricature
    @caricature = Media.caricatures.find_by_id(params[:id])
    if @caricature
      render :inline => "<%= image_tag url_for_file_column('caricature','file'), {:class => 'feature_image', :alt => 'caricature', :style => 'width:232px;'} %>"
    else
      render :inline => "<i>none selected</i>"
    end
  end

protected

  def update_protected
    permit "admin"
    @media.user          = User.find_by_id(params[:media][:user_id])
    if @media.status == "Published"
      @media.published_at = parsed_published_at
      xmlrpc_ping
    else
      @media.published_at = nil
    end    
    @media.in_archive = params[:media][:in_archive]
    @media.status        = params[:media][:status]
  end
  
  def parsed_published_at
    # the datetime multiparameter assignment is messing up published_at
    m = params[:media]
    year  = m["published_at(1i)"]
    month = m["published_at(2i)"]
    day   = m["published_at(3i)"]
    hour  = m["published_at(4i)"]
    min   = m["published_at(5i)"]
    return Time.mktime(year,month,day,hour,min)
  end
  
end

class Admin::PagesController < Admin::AdminController
  
  permit "admin"
  
  def index
    list
    render :action => 'list'
  end
  
  def list
    @pages = Page.parents
  end
  
  def new
    @page = Page.new
  end
  
  def create
    # if the commit parameter is preview then set the page attributes
    # and render the preview page

    
    @page = Page.new(params[:page])
    @page.created_at = Time.now
    @page.user = current_user
    if @page.save
      Activity.create(:action => @page, :description => "was created by #{current_user.name}", :user => current_user)
      case params[:commit]
      when "Save and Preview"
        # if the commit parameter is preview then set the page attributes
        # and render the preview page
        redirect_to preview_admin_page_path(@page)
      when "Save and Continue Editing"
        flash[:notice] = 'The page was successfully created.'
        redirect_to edit_admin_page_path(@page)
      when "Save"
        flash[:notice] = 'The page was successfully created.'
        redirect_to :action => 'list'
      end
    else
      flash[:notice] = 'An error has occurred.'
      render :action => 'new'
    end

  end
  
  def edit
    @page = Page.find_by_id(params[:id])
    # have to add in this incase this was redirected from the preview page
    @page.attributes = params[:page] unless params[:page].blank?    
    if @page.nil? 
      flash[:notice] = 'The page was not found.'
      redirect_to :action => "list" 
    end
  end
  
  def update
    @page = Page.find(params[:id])
    @page.user = current_user
    # else update the page as normal
    if @page.update_attributes(params[:page])
      Activity.create(:action => @page, :description => "was updated by #{current_user.name}", :user => current_user)
      case params[:commit]
      when "Save and Preview"
        # if the commit parameter is preview then set the page attributes
        # and render the preview page
        redirect_to preview_admin_page_path(@page)
      when "Save and Continue Editing"
        redirect_to edit_admin_page_path(@page)
      when "Save"
        flash[:notice] = "The page has been updated."
        redirect_to admin_pages_path
      end
    else
      flash[:notice] = 'An error has occurred.'
      render :action => 'edit'
    end
  end
  
  def preview
    @page = Page.find_by_id(params[:id])
    render :template => "/pages/show", :layout => "ecotrust"
  end
  
  def destroy
    Page.find(params[:id]).destroy
    Activity.create(:action => @page, :description => "was deleted by #{current_user.name}", :user => current_user)
    redirect_to :action => 'list'
  end
  
end

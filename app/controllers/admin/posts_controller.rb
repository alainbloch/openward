class Admin::PostsController < Admin::AdminController
  
  helper "associations", "media_library"
  
  def index
    @column = params[:column] || "updated_at"
    @order  = params[:order] || "DESC"
    if current_user.has_role? "admin"
      @posts = Post.paginate(:page => params[:page], :per_page => 10, :order => "#{@column} #{@order}") 
    elsif current_user.has_role? "contributor"
      @posts = current_user.posts.paginate(:page => params[:page], :per_page => 10, :order => "#{@column} #{@order}")
    end
  end
  
  def show
    edit
    render :action => "edit"
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if current_user.has_role? "admin"
      update_protected
    else
      @post.user = current_user
    end
    if @post.save
      Activity.create(:action => @post, :description => "was created by #{current_user.name}", :user => current_user)
      @post.accepts_role('owner', @post.user)
      case params[:commit]  
      when "Save and Preview"
        # if the commit parameter is preview then set the post attributes
        # and render the preview page
        redirect_to preview_admin_post_path(@post)
      when "Save and Continue Editing"
        flash[:notice] = 'The post was successfully created.'
        redirect_to edit_admin_post_path(@post)
      when "Save"
        redirect_to admin_posts_path
      when "Send to Editor"
        #need to add some code here to send some sort of message to the editor
        redirect_to admin_posts_path        
      end
    else
      flash[:notice] = 'An error has occurred.'
      render :action => 'new'
    end
  end

  def preview
    @post = Post.find_by_id(params[:id])
    @section = @post.sections.first
    @page_title =  %(#{@post.title} | P&P) if @post
    render :layout => "ecotrust"
  end
  
  def print_preview
    @post = Post.find_by_id(params[:id])
    @page_title =  %(#{@post.title} | P&P)
    render :layout => 'printable'
  end

  def edit
    @post = Post.find_by_id(params[:id])
    permit "admin or owner of :post"
    # have to add in this incase this was redirected from the preview page
    @post.attributes = params[:post] unless params[:post].blank?
    
    if @post.nil? 
      flash[:notice] = 'The post was not found.'
      redirect_to admin_posts_path
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    permit "admin or owner of :post"
    update_protected if current_user.has_role? "admin"
    if @post.update_attributes(params[:post])
      Activity.create(:action => @post, :description => "was updated by #{current_user.name}", :user => current_user)
      respond_to do |format|
        format.html do
          case params[:commit]  
          when "Save and Preview"
            # if the commit parameter is preview then set the post attributes
            # and render the preview page
            redirect_to preview_admin_post_path(@post)
          when "Save and Continue Editing"
            flash[:notice] = "The post has been updated."
            redirect_to edit_admin_post_path(@post)
          when "Save"
            redirect_to admin_posts_path
          when "Send to Editor"
            #need to add some code here to send some sort of message to the editor
            redirect_to admin_posts_path        
          end
        end
        format.js {}
      end

    else
      respond_to do |format|
        format.html do
          flash[:notice] = 'An error has occurred.'
          render :action => 'edit' 
        end
        format.js {}
      end
    end
  end
  
  def archive    
    @post = Post.find_by_id(params[:id])
    permit "admin or owner of :post"
    @post.update_attribute(:in_archive, params[:in_archive])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @post.in_archive
            page << "alert('Post is now in archive.');"
          else
            page << "alert('Post has been removed from archive.');"            
          end
        end
      end
    end
  end
  


  def destroy
    @post = Post.find(params[:id])
    permit "admin or owner of :post"

    if @post.destroy
      Activity.create(:action => @post, :description => "was deleted by #{current_user.name}", :user => current_user)
    end
    redirect_to admin_posts_path
  end
  
private

  def update_protected
    permit "admin"
    @post.user    = User.find_by_id(params[:post][:user_id]) || current_user
    @post.status  = params[:post][:status]
    if @post.status == "Published"
      @post.published_at = parsed_published_at
      xmlrpc_ping
    else
      @post.published_at = nil
    end
    @post.in_archive = params[:post][:in_archive]
  end
  
  def parsed_published_at
    # the datetime multiparameter assignment is messing up published_at
    p = params[:post]
    year  = p["published_at(1i)"]
    month = p["published_at(2i)"]
    day   = p["published_at(3i)"]
    hour  = p["published_at(4i)"]
    min   = p["published_at(5i)"]
    #dt = %(#{year}-#{month}-#{day} #{hour}:#{min})
    #return DateTime.parse(dt)
    return Time.mktime(year,month,day,hour,min)
  end
  
end

class Admin::CommentsController < Admin::AdminController
  
  before_filter :get_comment, :except => [:index]
  
  def index
    if current_user.has_role?('admin')
      @queued_comments   =  Comment.queued_comments
      @archived_comments =  Comment.archived_comments.paginate(:page => params[:page], :order => "updated_at DESC")
    elsif current_user.has_role?('contributor')
      # Needs to be fixed. Grab the comments associated with the contributor's posts and media
      @queued_comments   = []
      @archived_comments = [].paginate(:page => params[:page])
    end
  end

  def update
    @comment.attributes(params[:comment])
    @comment.new = false
    if @comment.save
      Activity.create(:action => @comment, :description => "has been updated by #{current_user.name}", :user => current_user)
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to :action => 'show', :id => @comment
    else
      render :action => 'edit'
    end
  end
  
  def archive
    @comment.archived = params[:archived]
    @comment.new = false
    if @comment.save
      Activity.create(:action => @comment, :description => "has been archived by #{current_user.name}", :user => current_user)
      render :update do |page|
          page.replace_html "queued_comments",   :partial => "comment_list", :locals => {:comments => Comment.queued_comments}
          page.replace_html "archived_comments", :partial => "comment_list", :locals => {:comments => Comment.archived_comments}
      end
    else
      render :update do |page|
        page << "alert('An error has occurred.');"
      end
    end
  end
  
  def reveal
    @comment.show = params[:show]
    @comment.new = false
    render :update do |page|      
      if @comment.save
        if @comment.show
          Activity.create(:action => @comment, :description => "has been approved by #{current_user.name}")
        else
          Activity.create(:action => @comment, :description => "has been disapproved by #{current_user.name}")
        end
      end
    end
  end

  def destroy
    @comment.destroy
    Activity.create(:action => @comment, :description => "has been deleted by #{current_user.name}", :user => current_user)
    redirect_to :action => 'index'
  end
  
private
  
  def get_comment
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    #permit "admin or owner of :commentable"
  end
  
end

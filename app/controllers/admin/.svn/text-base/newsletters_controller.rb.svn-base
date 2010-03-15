class Admin::NewslettersController < Admin::AdminController

  def new     
   @newsletter = Newsletter.new
   @issue      = Issue.find_by_id(params[:issue_id])
  end
  
  def create
    
    @issue      = Issue.find_by_id(params[:issue_id])
    @newsletter = @issue.newsletters.new(params[:newsletter])
    @newsletter.issue = @issue
    
    if params[:commit] == "Preview"
      render(:layout => false, :action => "preview") and return
    end
    
    @newsletter.html = render_to_string(:action  => "preview", :layout => false)
    @newsletter.text = render_to_string(:partial => "plain_text_version")
    
    if @newsletter.save
      flash[:notice] = "Newsletter has been created"
      redirect_to admin_issue_path(@issue)
    else
      flash[:error] = "There is an error in the newsletter."
      render :action => "new"
    end
  end

  def show
    @issue      = Issue.find_by_id(params[:issue_id])
    @newsletter = Newsletter.find_by_id(params[:id])
  end
  
  def destroy
    @newsletter = Newsletter.find_by_id(params[:id])
    @issue = @newsletter.issue
    if @newsletter.destroy
      flash[:success] = "Newsletter has been removed."
      
    else
      flash[:error] = "There is an error in the newsletter."
    end
    redirect_to admin_issue_path(@issue)
  end


  def send_out
    @newsletter = Newsletter.find_by_id(params[:id])
    @issue = Issue.find_by_id(params[:issue_id])
    if @newsletter.push_to_vertical_response
      flash[:success] = "Newsletter has been sent to Vertical Response."
    else
      flash[:error] = "An error occurred."
    end
    redirect_to admin_issue_newsletter_path(@issue)
  end
  
end

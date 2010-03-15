class Admin::IssuesController < Admin::AdminController
  
  permit "admin"
  
  def show
    edit
    render :action => "edit"
  end
  
  def create
    @volume = Volume.find_by_id(params[:issue][:volume_id])
    @issue = Issue.new(params[:issue])
    @issue.number = @volume.next_issue_number
    @issue.volume = @volume
    if @issue.save
      flash[:notice] = "Issue has been created"
      redirect_to admin_volumes_path
    else
      flash[:error] = "There is an error in the issue."
      render :action => "new"
    end
  end
  
  def new
   @issue = Issue.new
  end
  
  def edit
    @issue = Issue.find_by_id(params[:id])
  end
  
  def update
    @volume = Volume.find_by_id(params[:issue][:volume_id])
    @issue = Issue.find_by_id(params[:id])
    # Update the volume and the volume number only if its something different
    unless @issue.volume == @volume
      @issue.number = @volume.next_issue_number
      @issue.volume = @volume
    end
    if @issue.update_attributes(params[:issue])
      flash[:notice] = "Issue has been created"
      redirect_to admin_volumes_path
    else
      flash[:error] = "There is an error in the issue."
      render :template => "edit"
    end
  end
  
  def destroy
    @issue = Issue.find_by_id(params[:id])
    if @issue.destroy
      redirect_to admin_volumes_path
    else
      redirect_to :back
    end
  end
  
  def activate
    @issue = Issue.find_by_id(params[:active_issue])
    render :update do |page|
      if @issue.make_active
        page << "alert('Issue #{@issue.number} has been made active')"
      else
        page << "alert('An error has occurred and Issue #{@issue.number} has not been made active')"
      end
    end
  end
  
end

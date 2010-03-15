class Admin::UsersController < Admin::AdminController
  
  permit "admin", :except => [:edit, :update]
  
  def index
    @users = User.paginate(:page => params[:page],  :per_page => 30, :order => 'display_name')
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.add_roles(params[:roles].keys) if current_user.has_role?("admin") and params[:roles]
    if @user.save
      Activity.create(:action => @user, :description => "was created by #{current_user.name}", :user => current_user)
      @user.accepts_role?('owner',@user)
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
    permit "admin or owner of :user"
  end
  
  def update
    @user = User.find(params[:id])
    permit "admin or owner of :user"
    @user.add_roles(params[:roles].keys) if current_user.has_role?("admin") and params[:roles]
    if @user.update_attributes(params[:user])
      Activity.create(:action => @user, :description => "was updated by #{current_user.name}", :user => current_user)
      flash[:notice] = 'User was successfully updated.'
      redirect_to admin_users_path
    else
      flash[:notice] = 'An error has occurred.'      
      render :action => 'edit'
    end
  end  
    
  def destroy
    @user = User.find(params[:id]) rescue nil
    if @user and @user.destroy
      Activity.create(:action => @user, :description => "was deleted by #{current_user.name}", :user => current_user)
      flash[:notice] = "User was deleted."
    else
      flash[:notice] = "An error has occurred."        
    end  
    redirect_to admin_users_path
  end 
    
end

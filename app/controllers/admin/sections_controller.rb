class Admin::SectionsController < Admin::AdminController
  
  permit "admin"
  
  def index
    @sections = Section.find(:all)
  end
  
  def show
    @section = Section.find_by_id(params[:id])
  end
  
  def edit
    @section = Section.find_by_id(params[:id])
  end

  def new
    @section = Section.new
  end
  
  def update
    @section = Section.find_by_id(params[:id])
    if @section.update_attributes(params[:section])
      flash[:success] = "The section was updated."
      redirect_to admin_sections_path
    else
      flash[:error] = "The section was not updated."
      render :action => "edit"
    end
  end
  
  def destroy
    @section = Section.find_by_id(params[:id])
    if @section.destroy
      flash[:success] = "The section was removed."
      redirect_to admin_sections_path
    else
      flash[:error] = "The section was not removed."
      render :action => "edit"
    end
  end
  
  def create
    @section = Section.new(params[:section])
    if @section.save
      flash[:success] = "The section was created."
      redirect_to admin_sections_path
    else
      flash[:error] = "The section was not created."
      render :action => "new"    
    end
  end
  
end

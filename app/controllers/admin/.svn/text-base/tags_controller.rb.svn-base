class Admin::TagsController < Admin::AdminController
  
  permit "admin"
  
  def index
    @tags = Tag.find(:all, :order => "name ASC")
  end
  
  def show
    @tag = Tag.find_by_name(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
    respond_to do |wants|
      if @tag.save
        wants.html do
          flash[:notice] = 'Tag was successfully created.'
          redirect_to admin_tags_path
        end
        wants.js { flash[:notice] = "Tag was successfully created" }
      else
        wants.html { render :action => 'new' }
        wants.js { }
      end
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(params[:tag])
      flash[:notice] = 'Tag was successfully updated.'
      redirect_to admin_tags_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    Tag.find(params[:id]).destroy
    redirect_to admin_tags_path
  end
end

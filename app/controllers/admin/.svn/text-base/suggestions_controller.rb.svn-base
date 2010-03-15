class Admin::SuggestionsController < Admin::AdminController
  
  permit "admin"
  
  def index
    @suggestions = Suggestion.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @suggestion = Suggestion.find(params[:id])
  end

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(params[:suggestion])
    if @suggestion.save
      flash[:notice] = 'Suggestion was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def update
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.update_attributes(params[:suggestion])
      flash[:notice] = 'Suggestion was successfully updated.'
      redirect_to :action => 'show', :id => @suggestion
    else
      render :action => 'edit'
    end
  end

  def destroy
    Suggestion.find_by_id(params[:id]).destroy
    redirect_to admin_suggestions_path
  end
end

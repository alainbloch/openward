class TagsController < ApplicationController

  def show
    @tag = Tag.find_by_name(params[:name])
    @taggables = @tag.taggables.paginate(:page => params[:page], :per_page => 20, :order => "published_at DESC")
    @tags = Tag.find(:all, :order => "name ASC")
  end

end

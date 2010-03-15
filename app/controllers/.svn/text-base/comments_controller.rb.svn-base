class CommentsController < ApplicationController
  
  before_filter :get_commentable
  
  def create
    @visitor = Visitor.new(params[:visitor])
    @comment = Comment.new(params[:comment].merge({:show        => !@setting.comment_moderation, 
                                                   :commentable => @commentable,
                                                   :commentator => @visitor,
                                                   :subscribe   => params[:subscribe]}))
    respond_to do |format|
      format.js {} # create.rjs
      format.html {redirect_to :back}
    end
  end
  
  def preview
    content = Sanitize.clean(params[:comment][:content], Sanitize::Config::BASIC)
    @comment = Comment.new(:content => content)
    respond_to do |format|
      format.js {}
      format.html {redirect_to :back}
    end
  end
  
  def input_field
    content = Sanitize.clean(params[:comment][:content], Sanitize::Config::BASIC)
    @comment = Comment.new(:content => content)
    respond_to do |format|
      format.js {}
      format.html {redirect_to :back}
    end
  end
  
private

  def get_commentable
    @commentable_type = params[:commentable_type]
    @commentable = 
    case @commentable_type
    when "Media"
      Media.find_by_id(params[:commentable_id])
    when "Post"
      Post.find_by_id_and_status(params[:commentable_id], Post::STATUS[1])
    end
  end
    
end

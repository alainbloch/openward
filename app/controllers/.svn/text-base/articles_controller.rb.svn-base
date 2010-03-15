class ArticlesController < ApplicationController
  before_filter :get_section, :except => [:redirector]
  
  def index
    @posts   = @section.posts.find_by_date(*params.values_at(:year, :month, :day)).paginate(:page => params[:page])
    @page_title =  %(People and Place: #{@section.name})
    respond_to do |format|
      format.html {}
      format.rss  {render :layout => false}
    end
  end
  
  def show
    @post = @section.posts.find_by_permalink(*params.values_at(:year, :month, :day, :article_id))
    @page_title =  %(#{@post.title} | P&P)   
    log_visit(@post)
    respond_to do |format|
      format.html {}
      format.rss  {render :layout => false}
      format.pdf  {send_data render_to_pdf({ :action => 'print', :layout => 'printable' }), :filename => "#{@post.uri}.pdf"}
    end
  end
  
  # This will point the old paths to the new ones
  def redirector
    unless params[:section_id].nil?
      get_section
      @post = @section.posts.find_by_id(params[:id])
    else
      @post = Post.find_by_id(params[:id])
      @section = @post.sections.first
    end
    redirect_to section_article_path(@post.permalink_params.merge(:section_id => @section.uri))
  end
  
  def print
    @post = @section.posts.find_by_permalink(*params.values_at(:year, :month, :day, :article_id))
    @page_title =  %(#{@post.title} | P&P)
    render :layout => 'printable'
  end
  
private

  def get_section
    @section = Section.find_by_uri(params[:section_id]) || Section.find_by_id(params[:section_id])
  end
  
end

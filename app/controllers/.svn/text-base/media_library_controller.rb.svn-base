class MediaLibraryController < ApplicationController
  
  before_filter :add_page_title, :except => [:show, :print]
  
  def index
    media_type = params[:media_type]
    if media_type != "all"
      @medias = Media.published.library.media_type(media_type).find_by_date(*params.values_at(:year, :month, :day)).paginate(:page => params[:page])
    else
      @medias = Media.published.library.paginate(:page => params[:page])    
    end
    respond_to do |format|
      format.html # index.rhtml
      format.rss { render :layout => false }
    end
  end
  
  def most_recent
    @medias = Media.published.library.paginate(:page => params[:page])
    render :action => 'index'
  end

=begin  #removing as per howard's request.
  def most_viewed
    @medias = Media.published.paginate_viewed(:page => params[:page])
    render :action => 'index'
  end
=end

  # This will point the old paths to the new ones
  def redirector
    @media = Media.find_by_id(params[:id])
    redirect_to media_path(@media.permalink_params)
  end
  
  def show
    media_type = params[:media_type]
    if media_type != "all"
      @media = Media.published.media_type(media_type).find_by_permalink(*params.values_at(:year, :month, :day, :media_id))
    else
      @media = Media.published.find_by_uri(params[:media_id])      
    end
    @page_title =  %(#{@media.title} | P&P) if @media
    log_visit(@media)
  end
  
  def print
    @media = Media.published.find_by_permalink(*params.values_at(:year, :month, :day, :media_id))
    @page_title =  %(#{@media.title} | P&P) if @media
    render :layout => "printable"
  end
  
private

  def add_page_title
    @page_title =  %(People and Place: Media Library) 
  end
  
end

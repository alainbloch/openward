class HomeController < ApplicationController
  
  def show
    @feature_section = Section.find_by_uri("featured_voices")    
    # Grab the most recent feature that is in a newsletter. 
    @feature      = @feature_section.posts.published.first
    @volume       = Volume.active_volume
    @issue        = @volume.active_issue
    respond_to do |format|
      format.html {  render :layout => false }
      format.rss do
        posts = Post.published
        media = Media.library.published
        @objects = (posts + media).sort{|a, b| b.published_at <=> a.published_at}
        render :layout => false
      end
    end
  end
  
end

module ArticlesHelper
  
  def render_correct_partial(posts = [])
    return if posts.empty?
    render(:partial => "/articles/#{@section.uri}", :collection => posts)
  end
  
end

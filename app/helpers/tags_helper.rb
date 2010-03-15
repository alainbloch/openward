module TagsHelper
  
  def render_taggable_partial(taggable = nil)
    return if taggable.nil?
    if taggable.class.to_s == "Post"
      @section = taggable.sections.first
      return render(:partial => "/articles/#{@section.uri}", :object => taggable)
    elsif taggable.class.to_s == "Media"
      return render(:partial => "media_library/media", :locals => {:media => taggable})
    end 
  end
  
  def tag_cloud(tags, classes)
    max, min = 0, 0
    tags.each { |t|
      max = t.count if t.count > max
      min = t.count if t.count < min
    }

    divisor = ((max - min) / classes.size) + 1

    tags.each { |t|
      yield t.name, classes[(t.count.to_i - min) / divisor]
    }
  end

  
  
  
  
end


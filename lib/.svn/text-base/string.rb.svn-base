class String
  def to_safe_uri
    self.strip.downcase.gsub('&', 'and').gsub(' ', '_').gsub(/[^\w-]/,'')
  end
  
  def to_url
    return self unless self.scan(/^http:\/\//).empty?
    return %(http://#{self})
  end
  
end
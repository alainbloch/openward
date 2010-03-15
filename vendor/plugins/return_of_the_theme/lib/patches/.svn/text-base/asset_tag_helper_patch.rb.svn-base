#
# These are patches to ActionView to get themes rollin'
#
module ActionView
  
  module Helpers
    
    module AssetTagHelper
            
      # The following modules are used in the different AssetTag classes (Stylesheetag, etc)
      # and can be found in the AssetTagHelper. These modules typically only have one directory
      # but I overloaded them to can add our theme specific directory.
      
      module StylesheetAsset
        attr_accessor :use_theme
      end
      
      module JavaScriptAsset
        attr_accessor :use_theme    
      end
      
      module ImageAsset
        attr_accessor :use_theme 
      end
      
     
      class AssetTag
        
        private
        
        def prepend_asset_host(source)
          if @include_host && source !~ ProtocolRegexp
            host = compute_asset_host(source)
            if request? && !host.blank? && host !~ ProtocolRegexp
              host = "#{request.protocol}#{host}"
            elsif request? and host.blank? and @use_theme and @controller.current_theme
              host = "#{request.protocol}#{request.host_with_port}/themes/#{@controller.current_theme}"
            else request? and host.blank?
              host = "#{request.protocol}#{request.host_with_port}"
            end
            "#{host}#{source}"
          else
            source
          end

        end
        
      end
     # returns the public path to a theme stylesheet
     def theme_stylesheet_path(source)
        stylesheet = StylesheetTag.new(self, @controller, source)
        stylesheet.use_theme = true
        stylesheet.public_path
     end
     alias_method :path_to_theme_stylesheet, :theme_stylesheet_path 


     # returns the path to a theme image
     def theme_image_path(source)
        imagetag = ImageTag.new(self, @controller, source)
        imagetag.use_theme = true        
        imagetag.public_path
     end
     alias_method :path_to_theme_image, :theme_image_path 
     
     
     # returns the path to a theme javascript
     def theme_javascript_path(source)
        javascript = JavaScriptTag.new(self, @controller, source)        
        javascript.use_theme = true
        javascript.public_path
     end
     alias_method :path_to_theme_javascript, :theme_javascript_path 

     def theme_javascript_tag(source, options = {})
       content_tag("script", "", {"type" => Mime::JS, "src" => path_to_theme_javascript(source) }.merge(options))
     end

     def theme_stylesheet_tag(source, options = {})
        tag("link", { "rel" => "stylesheet", "type" => Mime::CSS, "media" => "screen", "href" => html_escape(path_to_theme_stylesheet(source)) }.merge(options), false, false)
     end

     # This tag will return a theme-specific IMG
     def theme_image_tag(source, options = {})
       options.symbolize_keys
              
       options[:src] = theme_image_path(source)
       
       options[:alt] ||= File.basename(options[:src], '.*').split('.').first.to_s.capitalize
       
       if size = options.delete(:size)
         options[:width], options[:height] = size.split("x") if size =~ %r{^\d+x\d+$}
       end

       if mouseover = options.delete(:mouseover)
         if url
           options[:onmouseover] = "this.src='#{theme_image_url(mouseover)}'"
           options[:onmouseout]  = "this.src='#{theme_image_url(options[:src])}'"
         else
           options[:onmouseover] = "this.src='#{theme_image_path(mouseover)}'"
           options[:onmouseout]  = "this.src='#{theme_image_path(options[:src])}'"
         end
       end

       tag("img", options)
     end
   
     # This tag it will automatially include theme specific css files
     def theme_stylesheet_link_tag(*sources)
       options = sources.extract_options!.stringify_keys
       cache   = options.delete("cache")
       recursive = options.delete("recursive")
       @@new_directory = "themes/#{@controller.current_theme}/stylesheets"
            
       if ActionController::Base.perform_caching && cache
         joined_stylesheet_name = (cache == true ? "all" : cache) + ".css"
         joined_stylesheet_path = File.join("/#{@@new_directory}", joined_stylesheet_name)
         unless File.exists?(joined_stylesheet_path)
           StylesheetSources.create(self, @controller, sources, recursive).write_asset_file_contents(joined_stylesheet_path)
         end
         theme_stylesheet_tag(joined_stylesheet_name, options)          
       else
         StylesheetSources.create(self, @controller, sources, recursive).expand_sources.collect { |source|
           theme_stylesheet_tag(source, options)
         }.join("\n")
       end
     end
   
     # This tag can be used to return theme-specific javscripts
     def theme_javascript_include_tag(*sources)
       options = sources.extract_options!.stringify_keys
       cache   = options.delete("cache")
       recursive = options.delete("recursive")       
       @@new_directory = "themes/#{@controller.current_theme}/javascripts"

       if ActionController::Base.perform_caching && cache
         joined_javascript_name = (cache == true ? "all" : cache) + ".js"
         joined_javascript_path = File.join("/#{@@new_directory}", joined_javascript_name)

         unless File.exists?(joined_javascript_path)
           JavaScriptSources.create(self, @controller, sources, recursive).write_asset_file_contents(joined_javascript_path)
         end         
         theme_javascript_tag(joined_javascript_name, options)
       else
         JavaScriptSources.create(self, @controller, sources, recursive).expand_sources.collect { |source|
           theme_javascript_tag(source, options)
         }.join("\n")
       end
     end         

    end
  
  end
    
end
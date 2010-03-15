module WillPaginate
    module ViewHelpers
      # Add in a default option to the will_paginate pagination options
      @@pagination_options.merge(:remote => {})
    end  
    
    class LinkRenderer
    protected
      # We're going to overload the page_link method so we can include a remote link
      # The remote link is hampered a bit but we'll try...
      def page_link(page, text, attributes = {})
        if @options[:remote].blank?
          @template.link_to(text, url_for(page), attributes)
        else
          @template.link_to_remote(text, {:url => url_for(page), :method => :get}.merge(@options[:remote]), attributes)
        end
      end
      
    end
    
end
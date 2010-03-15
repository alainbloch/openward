# Extend the Base ActionController to support themes
ActionController::Base.class_eval do 

   attr_accessor :current_theme
   
   # Use this in your controller just like the <tt>layout</tt> macro.
   # Example:
   #
   #  theme 'theme_name'
   #
   # -or-
   #
   #  theme :get_theme
   #
   #  def get_theme
   #    'theme_name'
   #  end
   
   def self.theme(theme_name)
     write_inheritable_attribute "theme", theme_name
     before_filter :add_theme_path
   end

   # Retrieves the current set theme
   def current_theme(passed_theme=nil)
     theme = passed_theme || self.class.read_inheritable_attribute("theme")     
     @active_theme = case theme
       when Symbol then send(theme)
       when Proc   then theme.call(self)
       when String then theme
     end     
     return @active_theme
   end
   
   def add_theme_path
     if current_theme
       # Here is the simple way to redirect the view path to our theme directory.
       # The old way was to overload the render_file method ~ very messy.
       theme_path = File.expand_path(%(#{RAILS_ROOT}/themes/#{@active_theme}/views))
       unless self.view_paths.include?(theme_path)
         self.view_paths.unshift(theme_path)
       end
       logger.info %(Theme View Paths: #{self.view_paths}\n)
     end
     return true
   end

end
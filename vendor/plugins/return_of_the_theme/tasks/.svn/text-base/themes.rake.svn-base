namespace :themes do

  namespace :cache do

    desc "Creates the cached (public) theme folders"
    task :create => [:environment] do
      create
    end

    desc "Removes the cached (public) theme folders"
    task :remove => [:environment] do
      remove
    end

    desc "Updates the cached (public) theme folders"
    task :update => [:remove, :create]
    
    def create
      require "config/environment"
      require 'fileutils'
  
      for theme in Dir.glob("#{RAILS_ROOT}/themes/*")
        theme_name = theme.split( File::Separator )[-1]
        puts "Creating #{RAILS_ROOT}/public/themes/#{theme_name}"
    
        FileUtils.mkdir_p "#{RAILS_ROOT}/public/themes/#{theme_name}"
        
        FileUtils.cp_r "#{theme}/images", "#{RAILS_ROOT}/public/themes/#{theme_name}/images", :verbose => true
        FileUtils.cp_r "#{theme}/stylesheets", "#{RAILS_ROOT}/public/themes/#{theme_name}/stylesheets", :verbose => true
        FileUtils.cp_r "#{theme}/javascripts", "#{RAILS_ROOT}/public/themes/#{theme_name}/javascripts", :verbose => true
      end
    end
    
    def remove
      puts "Removing #{RAILS_ROOT}/public/themes"
      FileUtils.rm_r "#{RAILS_ROOT}/public/themes", :force => true
    end
    
  end
  
end
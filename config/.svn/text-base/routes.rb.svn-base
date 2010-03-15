ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.

  map.resource :home, :controller => 'home'
  
  map.root :controller => "home", :action => "show"
  
  map.protect '/protect', :controller => 'protect'  
  
  map.resource :subscribe, :controller => 'subscribe'
  
  map.resource :session
  
  map.resource :admin, :controller => "admin/admin"
  
  map.namespace :admin do |admin|
    admin.resource :settings
    admin.resource :dashboard, :controller => "dashboard"
    admin.resources :volumes, :member => {:active => :put}, :collection => {:activate => :post}
    admin.resources :comments,:member => {:archive => :put, :reveal => :put}
    admin.resources :pages,   :member => {:preview => :get}
    admin.resources :posts,   :member => {:preview => :get, :archive => :put, :print_preview => :get}
    admin.resources :medias,  :member => {:preview => :get, :archive => :put}, :collection => {:caricature => :post}
    admin.resources :tags
    admin.resources :users
    admin.resources :suggestions
    admin.resources :sections
    admin.resources :issues, :member => {:active => :put}, :collection => {:activate => :post} do |issue|
      issue.resources :newsletters, :member => {:send_out => :get}
    end
  end
  
  map.archive  '/archive/volume/:volume_number', :controller => 'archives', :action => 'volume', :volume_number => /\d/
  
  map.archive  '/archive/volume/:volume_number/issue/:issue_number', :controller => 'archives', :action => 'issue', :issue_number => /\d/, :volume_number => /\d/
  
  map.archives '/archive',     :controller => 'archives'
  
  map.resources :pages
  
  map.resources :comments, :collection => {:preview => :post, :input_field => :post}
    
  map.resource :connect, :controller => "connect"
  
  map.error "/error/:id", :controller => "errors", :action => "show"
      
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'  
    
  map.tag '/tag/:name', :controller => 'tags', :action => 'show'  
   

  media_options = {:controller => "media_library",
                   :media_type => /(video)|(audio)|(image)|(text)|(all)|(caricature)/,
                   :year    => /\d{4}/, 
                   :month   => /(?:[1-9]|1[012])/, 
                   :day     => /(?:[1-9]|[12]\d|3[01])/, 
                   :conditions => {:method => :get}, 
                   :action     => 'index'}

  map.with_options(media_options) do |dated|

      dated.media '/media_library/:media_type/:year/:month/:day/:media_id', :action  => 'show'
      dated.print_media '/media_library/:media_type/:year/:month/:day/:media_id/print', :action => 'print'
      dated.formatted_media '/media_library/:media_type/:year/:month/:day/:media_id.:format', :action => 'show'

      dated.media_library_year_month_day '/media_library/:media_type/:year/:month/:day'
      dated.formatted_media_library_year_month_day '/media_library/:media_type/:year/:month/:day.:format'

      dated.media_library_year_month '/media_library/:media_type/:year/:month', :day => nil
      dated.formatted_media_library_year_month '/media_library/:media_type/:year/:month.:format', :day => nil

      dated.media_library_year '/media_library/:media_type/:year', :month => nil, :day => nil
      dated.formatted_media_library_year '/media_library/:media_type/:year.:format', :month => nil, :day => nil

      dated.media_library '/media_library/:media_type', :year => nil, :month => nil, :day => nil
      dated.formatted_media_library '/media_library/:media_type.:format', :year => nil, :month => nil, :day => nil

  end

  map.most_recent_media_library '/media_library/most_recent', :controller => 'media_library', :action => 'most_recent'

  map.most_viewed_media_library '/media_library/most_viewed', :controller => 'media_library', :action => 'most_viewed'

  # This will point the old paths to the new ones
  map.connect '/media_library/:id', :controller => 'media_library', :action => 'redirector', :id => /\d{1,3}/

  dated_options = {:year    => /\d{4}/, 
                   :month   => /(?:[1-9]|1[012])/, 
                   :day     => /(?:[1-9]|[12]\d|3[01])/, 
                   :conditions => {:method => :get}, 
                   :controller => 'articles',
                   :action     => 'index',
                   :section_id => /(perspectives)|(on_the_wire)|(featured_voices)|(our_compass)|\d/ }                                                                

  map.with_options(dated_options) do |dated|

      dated.section_article '/:section_id/:year/:month/:day/:article_id', :action  => 'show'
      dated.print_article '/:section_id/:year/:month/:day/:article_id/print', :action  => 'print'
      dated.formatted_section_article '/:section_id/:year/:month/:day/:article_id.:format', :action => 'show'

      dated.section_year_month_day '/:section_id/:year/:month/:day'
      dated.formatted_section_year_month_day '/:section_id/:year/:month/:day.:format'

      dated.section_year_month '/:section_id/:year/:month', :day => nil
      dated.formatted_section_year_month '/:section_id/:year/:month.:format', :day => nil

      dated.section_year '/:section_id/:year', :month => nil, :day => nil
      dated.formatted_section_year '/:section_id/:year.:format', :month => nil, :day => nil

      dated.section '/:section_id', :year => nil, :month => nil, :day => nil
      dated.formatted_section '/:section_id.:format', :year => nil, :month => nil, :day => nil
  end

  # This will point the old paths to the new ones
  map.connect '/articles/:id', :controller => 'articles', :action => 'redirector', :id => /\d{1,3}/
  
  # This will point the old paths to the new ones
  map.connect '/:section_id/:id', :controller => 'articles', :action => 'redirector', :id => /\d{1,3}/


  map.page '/:id',
 						:controller => 'pages',
 						:action     => 'show'
 							
  map.formatted_page '/:id.:format',
 							        :controller => 'pages',
 							        :action     => 'show'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
   map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
   map.connect ':controller/:action/:id.:format'
   map.connect ':controller/:action/:id'

  
end

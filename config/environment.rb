# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Set Authorization plugin's default redirection. 
# See authorization.rb in the plugin’s /lib directory for the default values of DEFAULT_REDIRECTION_HASH and STORE_LOCATION_METHOD.
AUTHORIZATION_MIXIN = "object roles"
LOGIN_REQUIRED_REDIRECTION    = {:controller => '/sessions', :action => 'new' }
PERMISSION_DENIED_REDIRECTION = {:controller => '/sessions', :action => 'new' }

# Vertical Response Settings
VR_USERNAME     = "support@ecotrust.org"
VR_PASSWORD     = "t3rrac3w3dd1ng"
VR_SESSION_TIME = 4 # How many minutes until the session id expires
VR_REDIRECT     = "http://www.verticalresponse.com"
VR_KEY          = "vr_key"
VR_CERT         = "vr_cert"
VR_WSDL         = "https://api.verticalresponse.com/partner-wsdl/1.0/VRAPI.wsdl"
#Enterprise WSDL url : "https://api.verticalresponse.com/wsdl/1.0/VRAPI.wsdl"

TEST_LIST_ID    = 1415001840

# Blogs to Ping using the admin/posts controller 
PING_SERVICES = ["http://blogsearch.google.com/ping/RPC2",
                 "http://rpc.technorati.com/rpc/ping"]
                 
PING_BLOG_NAME = 'People & Place'
PING_BLOG_URL  = 'http://www.peopleandplace.net'


# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.
  
  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "htmldoc"

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  config.plugins = [ :all ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  config.load_paths += Dir["#{RAILS_ROOT}/vendor/gems/**"].map do |dir| 
    File.directory?(lib = "#{dir}/lib") ? lib : dir
  end  
  
  # Config the time zone for Pacific time.
  config.time_zone = 'Pacific Time (US & Canada)'
  
  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store
  
  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_people_and_place_session',
    :secret      => '9375b890f53a89cccb13798c82407d0ade02f770c90464a4cf8dd50eaac225c7b47f9f4df85d5028229fa6e2dc9f5e811a28c6ce57a6cf889f8a5417bc9aa52d'
  }

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end

# For pdf generation we use HTMLDOC (http://www.htmldoc.org) and the HTMLDOC gem (gem install htmldoc)
require 'htmldoc'
require 'bluecloth'
require "ruby-debug"

# Email settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.smtp_settings = {
  :domain     => "peopleandplace.net",
  :address    => "mail.peopleandplace.net",
  :port       => 26,
  :user_name  => "bot@peopleandplace.net",
  :password   => "9rgCQwX64s",
  :authentication => :login
}
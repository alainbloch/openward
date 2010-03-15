require 'digest/sha1'

class User < ActiveRecord::Base


validates_presence_of     :password,              :if => :password_required?
validates_presence_of     :password_confirmation, :if => :password_required?
validates_confirmation_of :password,              :if => :password_required?
validates_length_of       :password, :within => 5..30, :if => :password_required?

validates_length_of       :display_name,    :within => 3..30
validates_uniqueness_of   :display_name,  :case_sensitive => false

validates_uniqueness_of   :email, :case_sensitive => false, :allow_nil => true, :allow_blank => true
validates_length_of       :email, :within => 5..30, :allow_nil => true, :allow_blank => true
validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_nil => true, :allow_blank => true

has_many :posts, :dependent => :nullify

has_many :medias, :dependent => :nullify
has_many :comments, :as => :commentator, :dependent => :nullify
has_many :suggestions, :dependent => :nullify
has_many :pages, :dependent => :nullify

has_many :activities, :as => :action
has_many :activities

acts_as_authorizable
acts_as_authorized_user

attr_accessor :password
attr_protected :confirmed, :salt, :crypted_password, :issue_id

  def before_save 
    encrypt_password unless password.blank?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    user = User.find_by_email(email) # need to get the salt
    user && user.authenticated?(password) ? user : nil
  end
  
  def authenticated?(password)
    return false if self.crypted_password.nil? or self.crypted_password.blank?
    return true if self.crypted_password == encrypt(password)
    false
  end
  
  def name
    return "#{self.first_name} #{self.last_name}"
  end

  def add_roles(role_names = [])
    # this only deals with site roles
    site_role_names = Role::SITE_ROLE_NAMES
    #remove prev site roles
    site_role_names.each do |role_name|
      self.has_no_role role_name
    end
    
    # add new site roles
    role_names.each do |role_name|
      self.has_role role_name
    end
  end
  
  def remember_token?
    remember_token_expires_at and Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering users
  # between browser closes
  def remember_me
    remember_me_for 2.years
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    key = "#{email}--#{remember_token_expires_at}"
    self.remember_token = Digest::SHA1.hexdigest(key)
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

protected

  def password_required?
    !password.blank?
  end

  def encrypt_password
    self.salt = create_salt(self.email) if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def encrypt(password)
    Digest::SHA1.hexdigest("#{self.salt}--#{password}--")
  end

  def create_salt(email)
    Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--")
  end

end

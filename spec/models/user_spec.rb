require File.dirname(__FILE__) + '/../spec_helper'

require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before(:each) do
    @user = User.new
  end

  it "should not be valid" do
    @user.should_not be_valid
  end
  
end


describe User, "A new user" do
  include SpecHelper
  fixtures :users
  
  before do
    @user = User.new
  end

  
  it "should be invalid with missing display name" do
    @user.attributes = valid_user_attributes.except(:display_name)
    @user.should have(1).error_on(:display_name)   
  end
  
  it "should be invalid with a non-unique display name" do
    @user.attributes = valid_user_attributes.except(:display_name)
    @user.display_name = users(:user).display_name
    @user.should  have(1).error_on(:display_name)    
  end
  
  it "should be invalid with missing email address" do
    @user.attributes = valid_user_attributes.except(:email)
    @user.should  have(2).error_on(:email)    # error on missing and size
  end
  
  it "should be invalid with non-unique email address" do
    @user.attributes = valid_user_attributes.except(:email)
    @user.email = users(:user).email
    @user.should  have(1).error_on(:email)  
  end
  
  it "should be invalid with non-valid email address" do
    @user.attributes = valid_user_attributes.except(:email)
    @user.email = "blahblah"
    @user.should  have(1).error_on(:email)  
  end  
  
  it "should be invalid with missing password" do
    @user.attributes = valid_user_attributes.except(:password)
    @user.should  have(3).error_on(:password) # error on missing, size, and not matching password confirmation
  end
  
  it "should be invalid with missing password confirmation" do
    @user.attributes = valid_user_attributes.except(:password_confirmation)
    @user.should  have(1).error_on(:password_confirmation)
  end
  
  it "should be invalid with password not matching password confirmation" do
    @user.attributes = valid_user_attributes
    @user.password = "newpassword"
    @user.should have(1).error_on(:password)
  end
  
  it "should be invalid with an email address less than 3 characters" do
    @user.attributes = valid_user_attributes
    @user.email = "hi"
    @user.should have(2).error_on(:email) #error on size, and invalid email
  end
  
  it "should be invalid with a password less than 4 characters" do
    @user.attributes = valid_user_attributes
    @user.password = @user.password_confirmation = "hey"
    @user.should have(1).error_on(:password)
  end
  
  it "should create a salt and encrypted password when its created" do
    @user.attributes = valid_user_attributes
    @user.save
    @user.salt.should_not == nil
    @user.crypted_password.should_not == nil
  end
  
end

describe User, "A saved user" do
  include SpecHelper
  fixtures :users, :roles_users, :roles
  
  before do
    @user = users(:alain)
  end

  it "should authenticate itself when given a valid email, and password" do
    User.authenticate("alainbloch@gmail.com","secret").should  == @user
  end
  
  it "should not authenticate itself when given an invalid email, and valid password" do
    User.authenticate("alainbloch","secret").should == nil
  end
  
  it "should not authenticate itself when given an invalid email, and valid password" do
    User.authenticate("alainbloch@gmail.com","redder").should == nil
  end  
  
  it "should return the full name using the name method" do
    @user.name.should == 'Alain Bloch'
  end 
  
  it "should return true for an admin role" do
    @user.has_role?("admin").should == true
  end 
    
end
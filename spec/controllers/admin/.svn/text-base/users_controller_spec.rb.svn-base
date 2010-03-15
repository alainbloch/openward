require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::UsersController, "User controllers new function" do
  fixtures :users, :roles, :roles_users
  
  before do
    session[:user] = users(:alain)
    get :new
  end
  
  it "should create a new instance of user" do
    assigns[:user].new_record?.should == true
  end
  
  it "should render the new view" do
    response.should render_template("admin/users/new")
  end

end

describe Admin::UsersController, "User controllers creating a new user" do
  include SpecHelper
  fixtures :users, :roles, :roles_users
    
  before do
    session[:user] = users(:alain)
    @user = User.new(valid_user_attributes)
  end
  
  specify "should create a new user" do
    post :create, :user => valid_user_attributes
    User.find_by_email(@user.email).should_not be nil
  end

  specify "should redirect to users/list upon successful account creation" do
    post :create, :user => valid_user_attributes
    response.should redirect_to("http://test.host/admin/users/list")  
  end

  specify "should redirect to users/new if the user could not save" do
    post :create, :user => valid_user_attributes.except(:password_confirmation)
    response.should redirect_to("http://test.host/admin/users/new") 
  end

end

describe Admin::UsersController, "User controllers editing a user" do
  include SpecHelper
  fixtures :users, :roles, :roles_users
    
  before do
    session[:user] = users(:alain)
    @user = users(:alain)
    get :edit, :id => @user.id
    assigns[:user].should == @user
  end

  specify "should render the edit view" do
    response.should render_template("admin/users/edit")
  end

  specify "should be able to update the user with valid attributes" do
    post :update, :id => @user.id, :user => valid_user_attributes
    flash[:notice].should == 'User was successfully updated.'
    response.should redirect_to("http://test.host/admin/users/list")      
  end

  specify "should not be able to update the user with invalid or missing attributes" do
    post :update, :id => @user.id, :user => valid_user_attributes.except(:password_confirmation)
    flash[:notice].should == 'An error has occurred.'
    response.should render_template("admin/users/edit")
  end
  
end  

describe Admin::UsersController, "User controllers deleting a user" do
  include SpecHelper
  fixtures :users, :roles, :roles_users
    
  before do
    session[:user] = users(:alain)
    @user = users(:alain)
  end

  specify "should be able to delete a valid user" do
    post :delete, :id => @user.id
    flash[:notice].should == 'User was deleted.'
    response.should redirect_to("http://test.host/admin/users/list")
  end
  
  specify "should give an error if the user isn't found when deleting a user" do
    post :delete, :id => nil
    flash[:notice].should == 'An error has occurred.'
    response.should redirect_to("http://test.host/admin/users/list")          
  end  
  
end  

describe Admin::UsersController, "Showing a user" do
  include SpecHelper
  fixtures :users, :roles, :roles_users

  before do
    session[:user] = users(:alain)
    @user = users(:alain)
    get :show, :id => @user.id
  end

  specify "should display the show view" do
    response.should render_template("admin/users/show")
  end 
  
  specify "should find and display the user" do
    assigns[:user].should == @user
  end
  
end
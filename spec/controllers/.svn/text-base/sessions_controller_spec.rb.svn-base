require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController, "The SessionsController create method " do
  controller_name :sessions
  fixtures :users
  
  it "should redirect to the admin controller with a valid user" do
    post :create, :email => "alainbloch@gmail.com", :password => "secret"
    response.should redirect_to "http://test.host/admin"
  end
  
  it "should redirect to the session controller with an invalid user" do
    post :create, :email => "user@host.com", :password => "foofoo"
    flash[:error].should == "Oops! Invalid email/password combination"
    response.should render_template "sessions/new"
  end

end


describe SessionsController, "The SessionsController index method " do
  controller_name :sessions
  fixtures :users
  
  it "should render the new method " do
    get :index
    response.should render_template "sessions/new"
  end

end


describe SessionsController, "The SessionsController new method " do
  controller_name :sessions
  fixtures :users
  
  it "should have a new method " do
    get :new
  end

end

describe SessionsController, "The SessionsController destroy method " do
  controller_name :sessions
  fixtures :users
  
  before do
    session[:user] = users(:alain)
    post :sign_out
  end
  
  it "should delete the session user " do
    session[:user].should == nil
  end
  
  it "should redirect to the login page" do
    response.should redirect_to "http://test.host/sessions/new"
  end
  
  it "should flash that the user has logged out" do
    flash[:notice].should == "You are now logged out."
  end

end
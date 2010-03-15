require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::AdminController do
  fixtures :users

  #Delete this example and add some real ones
  it "should use AdminController" do
    controller.should be_an_instance_of(Admin::AdminController)
  end
  
  it "should have an index method" do
    post :index
  end
  
  it "should create a current_user variable " do
    session[:user] = users(:alain)
    get :index
    assigns[:current_user].should == users(:alain)
  end
  
  it "should set the admin_item to true" do
    get :index
    assigns[:admin_item].should == true
  end

end


describe Admin::AdminController, "The Admin Controllers index" do
  fixtures :users
  
  before do
    session[:user] = users(:alain)
  end

  it "should be accessible an authenticated user" do
    post :index
  end
  
  it "should be inaccessible to an unauthenticated user" do
    session[:user] = nil
    post :index
    response.should redirect_to "http://test.host/sessions/new"
  end
  
end
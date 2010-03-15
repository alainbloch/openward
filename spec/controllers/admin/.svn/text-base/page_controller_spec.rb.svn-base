require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PageController do

  #Delete this example and add some real ones
  it "should use Admin::PageController" do
    controller.should be_an_instance_of(Admin::PageController)
  end

end

describe Admin::PageController, "The Admin Page Controllers index method" do
  fixtures :users, :roles, :roles_users
  
  before do
    session[:user] = users(:alain)
    get :index
  end
  
  it "should render the list view" do
    response.should render_template "admin/page/list"
  end

end

describe Admin::PageController, "The Admin Page Controllers list method" do
  fixtures :users, :roles, :roles_users
    
  before do
    session[:user] = users(:alain)
    get :list
  end
  
  it "should render the list view" do
    response.should render_template "admin/page/list"
  end
  
  it "should have an array of pages" do
    assigns[:pages].class.should == Array
  end
  
  it "should paginate the pages within a page_pages variable" do
    assigns[:page_pages].should_not == nil
  end

end

describe Admin::PageController, "The Admin Page Controllers new method" do
  fixtures :users, :roles, :roles_users
    
  before do
    session[:user] = users(:alain)
    get :new
  end
  
  it "should render the new view" do
    response.should render_template "admin/page/new"
  end
  
  it "should have a page variable assigned" do
    assigns[:page].should_not == nil
  end

end

describe Admin::PageController, "The Admin Page Controllers create method" do
  fixtures :pages, :users, :roles, :roles_users
  include SpecHelper
  
  before do
    session[:user] = users(:alain)
    @page = Page.new(valid_page_attributes)
  end
  
  it "should create a new page with valid params" do
    post :create, :page => valid_page_attributes
    Page.find_by_title(@page.title).should_not == nil
  end
  
  it "should redirect to the page list once a page is created" do
    post :create, :page => valid_page_attributes
    response.should redirect_to :action => "list"
  end
  
  it "should render the template view if the page is invalid" do 
    post :create, :page => valid_page_attributes.except(:title)
    response.should render_template("admin/page/new")
  end

  it "should flash an error message if page is invalid" do
    post :create, :page => valid_page_attributes.except(:title)
    flash[:notice].should == "An error has occurred."
  end

  it "should flash a notice message if the page is valid" do
    post :create, :page => valid_page_attributes
    flash[:notice].should == "The page was successfully created."
  end

end

describe Admin::PageController, "The Admin Page Controllers edit method" do
  fixtures :pages, :users, :roles, :roles_users
  include SpecHelper
  
  before do
    session[:user] = users(:alain)
    @page = pages(:about)
  end
  
  it "should render the edit view" do
    get :edit, :id => @page
    response.should render_template("admin/page/edit")
  end
  
  it "should have the page assigned" do
    get :edit, :id => @page
    assigns[:page].should == @page
  end
  
  it "should redirect to the list if it cannot find the page" do
    get :edit, :id => nil
    response.should redirect_to("admin/page/list")
  end

  it "should flash an error message if it cannot find the page" do
    get :edit, :id => nil
    flash[:notice].should == "The page was not found."
  end

end


describe Admin::PageController, "The Admin Page Controllers update method" do
  fixtures :pages, :users, :roles, :roles_users
  include SpecHelper
  
  before do
    session[:user] = users(:alain)
    @page = pages(:about)
  end
  
  it "should update a page with valid attributes" do
    @page.title = "About Us"
    post :update, :page => @page.attributes, :id => @page.id
    Page.find_by_title("About Us").should_not == nil 
  end
  
  it "should redirect to the list if the page is updated" do
    post :update, :page => @page.attributes, :id => @page.id
    response.should redirect_to("admin/page/list")    
  end
  
  it "should display a message when a page is updated" do
    post :update, :page => @page.attributes, :id => @page.id
    flash[:notice].should == "The page has been updated."
  end
  
  it "should display an error message when a page is not updated" do
    @page.title = ""
    post :update, :page => @page.attributes, :id => @page.id
    flash[:notice].should == "An error has occurred."
  end
  
  it "should render the edit view when a page is not updated" do
    @page.title = ""
    post :update, :page => @page.attributes, :id => @page.id
    response.should render_template("admin/page/edit")
  end
  

end

describe Admin::PageController, "The Admin Page Controllers destroy method" do
  fixtures :pages, :users, :roles, :roles_users
  include SpecHelper
  
  before do
    session[:user] = users(:alain)
    @page = pages(:about)
    delete :destroy, :id => @page.id
  end
  
  it "should delete a page" do
    Page.find_by_id(@page.id).should == nil 
  end
  
  it "should redirect to the pages list" do
    response.should redirect_to("admin/page/list")
  end

end

describe Admin::PageController, "The Admin Page Controllers preview method" do
  fixtures :pages, :users, :roles, :roles_users
  include SpecHelper
  
  before do
    session[:user] = users(:alain)
    @page = pages(:about)
    get :preview, :id => @page.id
  end
  
  it "should render the preview template" do
    response.should render_template("admin/page/preview")
  end


end


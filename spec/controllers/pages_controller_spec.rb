require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do

  #Delete this example and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end

end


describe PagesController, "Showing a page" do
  fixtures :pages
  include SpecHelper
  
  before do
    @page = pages(:about)
    get :show, :id => @page
  end
  
  it "should have the page assigned" do
    assigns[:page].should  == @page
  end
  
  it "should render the show page" do
    response.should render_template("pages/show")
  end
  
end


describe PagesController, "Showing a page by its url" do
  fixtures :pages
  include SpecHelper
  
  before do
    @page = pages(:about)
    get :show_by_url, :url => @page.url
  end
  
  it "should have the page assigned" do
    assigns[:page].should  == @page
  end
  
  it "should render the show page" do
    response.should render_template("pages/show")
  end
  
  it "should be findable through the url on the root path with an html extension" do
    route_for( :controller => 'pages', :action => 'show_by_url', :url => @page.url).should == "/#{@page.url}.html"
  end
  
  it "should return a 404 if it cannot be found" do
    get :show_by_url, :url => "foo"
    response.should render_template("#{RAILS_ROOT}/public/404.html")
  end
  
end


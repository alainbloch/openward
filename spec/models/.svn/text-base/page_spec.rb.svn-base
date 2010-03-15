require File.dirname(__FILE__) + '/../spec_helper'

describe Page, "When creating a new page" do
  fixtures :pages
  include SpecHelper
  
  before(:each) do
    @page = Page.new
  end

  it "should have a unique URL" do
    @page.attributes = valid_page_attributes.except(:url)
    @page.url = pages(:about).url
    @page.should have(1).error_on(:url)
  end
  
  it "should be invalid if the url uses non-alphanumeric characters and spaces" do
    @page.attributes = valid_page_attributes.except(:url)
    @page.url = "$ / ****"
    @page.should have(1).error_on(:url)
  end
  
  it "should be invalid if a title isn't provided" do
    @page.attributes = valid_page_attributes.except(:title)
    @page.should have(1).error_on(:title)
  end
  
end

describe Page, "When a page is save and a URL isn't provided" do
  fixtures :pages
  include SpecHelper
  
  before(:each) do
    @page = Page.new(valid_page_attributes.except(:url))
  end
  
  it "should automatically generate a URL if none is provided" do
    @page.save
    @page.url.should_not == ''
  end
    
  it "should use the title as a url but in lowercase" do
    @page.title = "About"
    @page.save
    @page.url.should == "about"
  end

  it "should use the title as a url and substitute spaces for dashes, and strip it of non-alphanumeric characters" do
    @page.title = " About Me And someone else ?"
    @page.save
    @page.url.should == "about_me_and_someone_else"
  end
  
end

describe Page, "Class methods of page" do
  fixtures :pages
  
#  it "should return only the active pages" do
#    pages = Page.find_active(:all)
#    pages.size.should == 1
#  end
  
#  it "should find active pages by the url" do
#    page = Page.find_active_by_url('about')
#    page.should_not == nil
#  end
  
#  it "should not find inactive pages by the url" do
#    page = Page.find_active_by_url('not_active')
#    page.should == nil
#  end
  
end
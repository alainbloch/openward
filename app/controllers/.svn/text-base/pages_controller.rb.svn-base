class PagesController < ApplicationController
  
  def show
    @page = Page.find_by_uri( params[:id], :conditions => ['status = ?', Page::STATUS[1]])
	  @page_title = %(People and Place: #{@page.title}) if @page
    if @page.nil?
      redirect_to error_path(404)
    else
      render :action => 'show'
    end
  end
  
end

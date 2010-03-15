class ArchivesController < ApplicationController
  
  # GET /archive/
  def index
    @volumes = Volume.find_all_archived
    @page_title =  %(People and Place: Archive)
  end
  
  # GET /archive/volume/1
  def volume
    @volume = Volume.find_by_number(params[:volume_number])
    @volumes = [@volume]
    @page_title =  %(People and Place: Volume #{@volume.number_string} Archive)
    render :action => 'index'
  end
  
  # GET /archive/volume/1/issue/1
  def issue
    @volume = Volume.find_by_number(params[:volume_number])
    @issue = @volume.issues.find_by_number(params[:issue_number])
    @feature = @issue.feature
    @volume_number = @volume.number_string
    @issue_number  = %(#{@issue.number_string} archive)
    @page_title =  %(People and Place: Volume #{@volume.number_string} Issue #{@issue.number_string} Archive)
    render :layout => "archive", :action => 'show'
  end
  
end

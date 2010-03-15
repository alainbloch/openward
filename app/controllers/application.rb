# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  require 'will_remotely_paginate'
  
  include SimpleCaptcha::ControllerHelpers
  include Authentication
  include SslRequirement
  
  theme "ecotrust"
  layout "ecotrust"  
  
  before_filter :get_settings, :get_volume_issue
    
  def log_visit(model = nil)
    return if model.nil?
    model.visits << Visit.create(:request => request, :session => session)
  end
  
  def get_settings
    @setting = Setting.find(:first) || Setting.create
  end
  
  def get_volume_issue
    volume = Volume.active_volume || Volume.first
    @volume_number = volume.number_string || "01"
    issue = volume.active_issue || volume.issues.first
    @issue_number  = issue.number_string || "01"
  end
  
  def render_to_pdf(options = nil)
    data = render_to_string(options)
    pdf = PDF::HTMLDoc.new
    pdf.set_option :bodycolor, :white
    pdf.set_option :toc, false
    pdf.set_option :portrait, true
    pdf.set_option :links, false
    pdf.set_option :webpage, true
    pdf.set_option :left, '2cm'
    pdf.set_option :right, '2cm'
    pdf << data
    pdf.generate
  end
  
end

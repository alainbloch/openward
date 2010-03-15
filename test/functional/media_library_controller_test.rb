require File.dirname(__FILE__) + '/../test_helper'
require 'media_library_controller'

# Re-raise errors caught by the controller.
class MediaLibraryController; def rescue_action(e) raise e end; end

class MediaLibraryControllerTest < Test::Unit::TestCase
  def setup
    @controller = MediaLibraryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

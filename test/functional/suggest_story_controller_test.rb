require File.dirname(__FILE__) + '/../test_helper'
require 'suggest_story_controller'

# Re-raise errors caught by the controller.
class SuggestStoryController; def rescue_action(e) raise e end; end

class SuggestStoryControllerTest < Test::Unit::TestCase
  def setup
    @controller = SuggestStoryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

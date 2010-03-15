require File.dirname(__FILE__) + '/../test_helper'
require 'suggestions_controller'

# Re-raise errors caught by the controller.
class SuggestionsController; def rescue_action(e) raise e end; end

class SuggestionsControllerTest < Test::Unit::TestCase
  fixtures :suggestions

  def setup
    @controller = SuggestionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = suggestions(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:suggestions)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:suggestion)
    assert assigns(:suggestion).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:suggestion)
  end

  def test_create
    num_suggestions = Suggestion.count

    post :create, :suggestion => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_suggestions + 1, Suggestion.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:suggestion)
    assert assigns(:suggestion).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Suggestion.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Suggestion.find(@first_id)
    }
  end
end

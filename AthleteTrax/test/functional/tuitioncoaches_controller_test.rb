require 'test_helper'

class TuitioncoachesControllerTest < ActionController::TestCase
  setup do
    @tuitioncoach = tuitioncoaches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tuitioncoaches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tuitioncoach" do
    assert_difference('Tuitioncoach.count') do
      post :create, tuitioncoach: @tuitioncoach.attributes
    end

    assert_redirected_to tuitioncoach_path(assigns(:tuitioncoach))
  end

  test "should show tuitioncoach" do
    get :show, id: @tuitioncoach
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tuitioncoach
    assert_response :success
  end

  test "should update tuitioncoach" do
    put :update, id: @tuitioncoach, tuitioncoach: @tuitioncoach.attributes
    assert_redirected_to tuitioncoach_path(assigns(:tuitioncoach))
  end

  test "should destroy tuitioncoach" do
    assert_difference('Tuitioncoach.count', -1) do
      delete :destroy, id: @tuitioncoach
    end

    assert_redirected_to tuitioncoaches_path
  end
end

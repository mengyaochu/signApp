require 'test_helper'

class ElectronicsControllerTest < ActionController::TestCase
  setup do
    @electronic = electronics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:electronics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create electronic" do
    assert_difference('Electronic.count') do
      post :create, electronic: @electronic.attributes
    end

    assert_redirected_to electronic_path(assigns(:electronic))
  end

  test "should show electronic" do
    get :show, id: @electronic.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @electronic.to_param
    assert_response :success
  end

  test "should update electronic" do
    put :update, id: @electronic.to_param, electronic: @electronic.attributes
    assert_redirected_to electronic_path(assigns(:electronic))
  end

  test "should destroy electronic" do
    assert_difference('Electronic.count', -1) do
      delete :destroy, id: @electronic.to_param
    end

    assert_redirected_to electronics_path
  end
end

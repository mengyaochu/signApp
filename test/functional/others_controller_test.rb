require 'test_helper'

class OthersControllerTest < ActionController::TestCase
  setup do
    @other = others(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:others)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create other" do
    assert_difference('Other.count') do
      post :create, other: @other.attributes
    end

    assert_redirected_to other_path(assigns(:other))
  end

  test "should show other" do
    get :show, id: @other.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @other.to_param
    assert_response :success
  end

  test "should update other" do
    put :update, id: @other.to_param, other: @other.attributes
    assert_redirected_to other_path(assigns(:other))
  end

  test "should destroy other" do
    assert_difference('Other.count', -1) do
      delete :destroy, id: @other.to_param
    end

    assert_redirected_to others_path
  end
end

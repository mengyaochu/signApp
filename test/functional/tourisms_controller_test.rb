require 'test_helper'

class TourismsControllerTest < ActionController::TestCase
  setup do
    @tourism = tourisms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tourisms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tourism" do
    assert_difference('Tourism.count') do
      post :create, tourism: @tourism.attributes
    end

    assert_redirected_to tourism_path(assigns(:tourism))
  end

  test "should show tourism" do
    get :show, id: @tourism
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tourism
    assert_response :success
  end

  test "should update tourism" do
    put :update, id: @tourism, tourism: @tourism.attributes
    assert_redirected_to tourism_path(assigns(:tourism))
  end

  test "should destroy tourism" do
    assert_difference('Tourism.count', -1) do
      delete :destroy, id: @tourism
    end

    assert_redirected_to tourisms_path
  end
end

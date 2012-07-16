require 'test_helper'

class BeautiesControllerTest < ActionController::TestCase
  setup do
    @beauty = beauties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beauties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beauty" do
    assert_difference('Beauty.count') do
      post :create, beauty: @beauty.attributes
    end

    assert_redirected_to beauty_path(assigns(:beauty))
  end

  test "should show beauty" do
    get :show, id: @beauty.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @beauty.to_param
    assert_response :success
  end

  test "should update beauty" do
    put :update, id: @beauty.to_param, beauty: @beauty.attributes
    assert_redirected_to beauty_path(assigns(:beauty))
  end

  test "should destroy beauty" do
    assert_difference('Beauty.count', -1) do
      delete :destroy, id: @beauty.to_param
    end

    assert_redirected_to beauties_path
  end
end

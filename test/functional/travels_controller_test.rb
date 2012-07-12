require 'test_helper'

class TravelsControllerTest < ActionController::TestCase
  setup do
    @travel = travels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel" do
    assert_difference('Travel.count') do
      post :create, travel: @travel.attributes
    end

    assert_redirected_to travel_path(assigns(:travel))
  end

  test "should show travel" do
    get :show, id: @travel.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travel.to_param
    assert_response :success
  end

  test "should update travel" do
    put :update, id: @travel.to_param, travel: @travel.attributes
    assert_redirected_to travel_path(assigns(:travel))
  end

  test "should destroy travel" do
    assert_difference('Travel.count', -1) do
      delete :destroy, id: @travel.to_param
    end

    assert_redirected_to travels_path
  end
end

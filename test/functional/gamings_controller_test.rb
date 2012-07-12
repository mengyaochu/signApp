require 'test_helper'

class GamingsControllerTest < ActionController::TestCase
  setup do
    @gaming = gamings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gamings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gaming" do
    assert_difference('Gaming.count') do
      post :create, gaming: @gaming.attributes
    end

    assert_redirected_to gaming_path(assigns(:gaming))
  end

  test "should show gaming" do
    get :show, id: @gaming.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gaming.to_param
    assert_response :success
  end

  test "should update gaming" do
    put :update, id: @gaming.to_param, gaming: @gaming.attributes
    assert_redirected_to gaming_path(assigns(:gaming))
  end

  test "should destroy gaming" do
    assert_difference('Gaming.count', -1) do
      delete :destroy, id: @gaming.to_param
    end

    assert_redirected_to gamings_path
  end
end

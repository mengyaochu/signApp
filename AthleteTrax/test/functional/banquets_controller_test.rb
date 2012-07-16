require 'test_helper'

class BanquetsControllerTest < ActionController::TestCase
  setup do
    @banquet = banquets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banquets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banquet" do
    assert_difference('Banquet.count') do
      post :create, banquet: @banquet.attributes
    end

    assert_redirected_to banquet_path(assigns(:banquet))
  end

  test "should show banquet" do
    get :show, id: @banquet.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banquet.to_param
    assert_response :success
  end

  test "should update banquet" do
    put :update, id: @banquet.to_param, banquet: @banquet.attributes
    assert_redirected_to banquet_path(assigns(:banquet))
  end

  test "should destroy banquet" do
    assert_difference('Banquet.count', -1) do
      delete :destroy, id: @banquet.to_param
    end

    assert_redirected_to banquets_path
  end
end

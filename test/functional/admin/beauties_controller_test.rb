require 'test_helper'

class Admin::BeautiesControllerTest < ActionController::TestCase
  setup do
    @admin_beauty = admin_beauties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_beauties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_beauty" do
    assert_difference('Admin::Beauty.count') do
      post :create, admin_beauty: @admin_beauty.attributes
    end

    assert_redirected_to admin_beauty_path(assigns(:admin_beauty))
  end

  test "should show admin_beauty" do
    get :show, id: @admin_beauty.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_beauty.to_param
    assert_response :success
  end

  test "should update admin_beauty" do
    put :update, id: @admin_beauty.to_param, admin_beauty: @admin_beauty.attributes
    assert_redirected_to admin_beauty_path(assigns(:admin_beauty))
  end

  test "should destroy admin_beauty" do
    assert_difference('Admin::Beauty.count', -1) do
      delete :destroy, id: @admin_beauty.to_param
    end

    assert_redirected_to admin_beauties_path
  end
end

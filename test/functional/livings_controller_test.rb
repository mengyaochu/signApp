require 'test_helper'

class LivingsControllerTest < ActionController::TestCase
  setup do
    @living = livings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:livings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create living" do
    assert_difference('Living.count') do
      post :create, living: @living.attributes
    end

    assert_redirected_to living_path(assigns(:living))
  end

  test "should show living" do
    get :show, id: @living.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @living.to_param
    assert_response :success
  end

  test "should update living" do
    put :update, id: @living.to_param, living: @living.attributes
    assert_redirected_to living_path(assigns(:living))
  end

  test "should destroy living" do
    assert_difference('Living.count', -1) do
      delete :destroy, id: @living.to_param
    end

    assert_redirected_to livings_path
  end
end

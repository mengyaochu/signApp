require 'test_helper'

class EntertainmentsControllerTest < ActionController::TestCase
  setup do
    @entertainment = entertainments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entertainments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entertainment" do
    assert_difference('Entertainment.count') do
      post :create, entertainment: @entertainment.attributes
    end

    assert_redirected_to entertainment_path(assigns(:entertainment))
  end

  test "should show entertainment" do
    get :show, id: @entertainment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entertainment
    assert_response :success
  end

  test "should update entertainment" do
    put :update, id: @entertainment, entertainment: @entertainment.attributes
    assert_redirected_to entertainment_path(assigns(:entertainment))
  end

  test "should destroy entertainment" do
    assert_difference('Entertainment.count', -1) do
      delete :destroy, id: @entertainment
    end

    assert_redirected_to entertainments_path
  end
end

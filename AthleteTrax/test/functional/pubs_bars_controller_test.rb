require 'test_helper'

class PubsBarsControllerTest < ActionController::TestCase
  setup do
    @pubs_bar = pubs_bars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pubs_bars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pubs_bar" do
    assert_difference('PubsBar.count') do
      post :create, pubs_bar: @pubs_bar.attributes
    end

    assert_redirected_to pubs_bar_path(assigns(:pubs_bar))
  end

  test "should show pubs_bar" do
    get :show, id: @pubs_bar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pubs_bar
    assert_response :success
  end

  test "should update pubs_bar" do
    put :update, id: @pubs_bar, pubs_bar: @pubs_bar.attributes
    assert_redirected_to pubs_bar_path(assigns(:pubs_bar))
  end

  test "should destroy pubs_bar" do
    assert_difference('PubsBar.count', -1) do
      delete :destroy, id: @pubs_bar
    end

    assert_redirected_to pubs_bars_path
  end
end

require 'test_helper'

class MixedBagsControllerTest < ActionController::TestCase
  setup do
    @mixed_bag = mixed_bags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mixed_bags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mixed_bag" do
    assert_difference('MixedBag.count') do
      post :create, mixed_bag: @mixed_bag.attributes
    end

    assert_redirected_to mixed_bag_path(assigns(:mixed_bag))
  end

  test "should show mixed_bag" do
    get :show, id: @mixed_bag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mixed_bag
    assert_response :success
  end

  test "should update mixed_bag" do
    put :update, id: @mixed_bag, mixed_bag: @mixed_bag.attributes
    assert_redirected_to mixed_bag_path(assigns(:mixed_bag))
  end

  test "should destroy mixed_bag" do
    assert_difference('MixedBag.count', -1) do
      delete :destroy, id: @mixed_bag
    end

    assert_redirected_to mixed_bags_path
  end
end

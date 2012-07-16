require 'test_helper'

class OfferDetailsControllerTest < ActionController::TestCase
  setup do
    @offer_detail = offer_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_detail" do
    assert_difference('OfferDetail.count') do
      post :create, offer_detail: @offer_detail.attributes
    end

    assert_redirected_to offer_detail_path(assigns(:offer_detail))
  end

  test "should show offer_detail" do
    get :show, id: @offer_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer_detail
    assert_response :success
  end

  test "should update offer_detail" do
    put :update, id: @offer_detail, offer_detail: @offer_detail.attributes
    assert_redirected_to offer_detail_path(assigns(:offer_detail))
  end

  test "should destroy offer_detail" do
    assert_difference('OfferDetail.count', -1) do
      delete :destroy, id: @offer_detail
    end

    assert_redirected_to offer_details_path
  end
end

require 'test_helper'

class TenentsControllerTest < ActionController::TestCase
  setup do
    @tenent = tenents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tenents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tenent" do
    assert_difference('Tenent.count') do
      post :create, tenent: { individual_id: @tenent.individual_id, lease_expired: @tenent.lease_expired, leased_signed: @tenent.leased_signed, property_id: @tenent.property_id, room_id: @tenent.room_id }
    end

    assert_redirected_to tenent_path(assigns(:tenent))
  end

  test "should show tenent" do
    get :show, id: @tenent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tenent
    assert_response :success
  end

  test "should update tenent" do
    patch :update, id: @tenent, tenent: { individual_id: @tenent.individual_id, lease_expired: @tenent.lease_expired, leased_signed: @tenent.leased_signed, property_id: @tenent.property_id, room_id: @tenent.room_id }
    assert_redirected_to tenent_path(assigns(:tenent))
  end

  test "should destroy tenent" do
    assert_difference('Tenent.count', -1) do
      delete :destroy, id: @tenent
    end

    assert_redirected_to tenents_path
  end
end

require 'test_helper'

class LeasesControllerTest < ActionController::TestCase
  setup do
    @lease = leases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lease" do
    assert_difference('Lease.count') do
      post :create, lease: { agent_references: @lease.agent_references, client_id: @lease.client_id, comments: @lease.comments, date: @lease.date, dropped_date: @lease.dropped_date, move_in: @lease.move_in, move_out: @lease.move_out, property_id: @lease.property_id, referral_amount: @lease.referral_amount, rental_amount: @lease.rental_amount, thank_you_sent: @lease.thank_you_sent, welcome_home: @lease.welcome_home }
    end

    assert_redirected_to lease_path(assigns(:lease))
  end

  test "should show lease" do
    get :show, id: @lease
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lease
    assert_response :success
  end

  test "should update lease" do
    patch :update, id: @lease, lease: { agent_references: @lease.agent_references, client_id: @lease.client_id, comments: @lease.comments, date: @lease.date, dropped_date: @lease.dropped_date, move_in: @lease.move_in, move_out: @lease.move_out, property_id: @lease.property_id, referral_amount: @lease.referral_amount, rental_amount: @lease.rental_amount, thank_you_sent: @lease.thank_you_sent, welcome_home: @lease.welcome_home }
    assert_redirected_to lease_path(assigns(:lease))
  end

  test "should destroy lease" do
    assert_difference('Lease.count', -1) do
      delete :destroy, id: @lease
    end

    assert_redirected_to leases_path
  end
end

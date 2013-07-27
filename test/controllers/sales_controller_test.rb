require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  setup do
    @sale = sales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale" do
    assert_difference('Sale.count') do
      post :create, sale: { agent_id: @sale.agent_id, closing_date: @sale.closing_date, company: @sale.company, hear: @sale.hear, individual_id: @sale.individual_id, office_number: @sale.office_number, property_id: @sale.property_id }
    end

    assert_redirected_to sale_path(assigns(:sale))
  end

  test "should show sale" do
    get :show, id: @sale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale
    assert_response :success
  end

  test "should update sale" do
    patch :update, id: @sale, sale: { agent_id: @sale.agent_id, closing_date: @sale.closing_date, company: @sale.company, hear: @sale.hear, individual_id: @sale.individual_id, office_number: @sale.office_number, property_id: @sale.property_id }
    assert_redirected_to sale_path(assigns(:sale))
  end

  test "should destroy sale" do
    assert_difference('Sale.count', -1) do
      delete :destroy, id: @sale
    end

    assert_redirected_to sales_path
  end
end

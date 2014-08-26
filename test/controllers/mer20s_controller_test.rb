require 'test_helper'

class Mer20sControllerTest < ActionController::TestCase
  setup do
    @mer20 = mer20s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mer20s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mer20" do
    assert_difference('Mer20.count') do
      post :create, mer20: { genome_id: @mer20.genome_id, lagging: @mer20.lagging, leading: @mer20.leading, sequence: @mer20.sequence }
    end

    assert_redirected_to mer20_path(assigns(:mer20))
  end

  test "should show mer20" do
    get :show, id: @mer20
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mer20
    assert_response :success
  end

  test "should update mer20" do
    patch :update, id: @mer20, mer20: { genome_id: @mer20.genome_id, lagging: @mer20.lagging, leading: @mer20.leading, sequence: @mer20.sequence }
    assert_redirected_to mer20_path(assigns(:mer20))
  end

  test "should destroy mer20" do
    assert_difference('Mer20.count', -1) do
      delete :destroy, id: @mer20
    end

    assert_redirected_to mer20s_path
  end
end

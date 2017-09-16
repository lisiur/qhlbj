require 'test_helper'

class RecommendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recommend = recommends(:one)
  end

  test "should get index" do
    get recommends_url, as: :json
    assert_response :success
  end

  test "should create recommend" do
    assert_difference('Recommend.count') do
      post recommends_url, params: { recommend: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show recommend" do
    get recommend_url(@recommend), as: :json
    assert_response :success
  end

  test "should update recommend" do
    patch recommend_url(@recommend), params: { recommend: {  } }, as: :json
    assert_response 200
  end

  test "should destroy recommend" do
    assert_difference('Recommend.count', -1) do
      delete recommend_url(@recommend), as: :json
    end

    assert_response 204
  end
end

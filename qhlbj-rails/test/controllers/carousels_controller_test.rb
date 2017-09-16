require 'test_helper'

class CarouselsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carousel = carousels(:one)
  end

  test "should get index" do
    get carousels_url, as: :json
    assert_response :success
  end

  test "should create carousel" do
    assert_difference('Carousel.count') do
      post carousels_url, params: { carousel: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show carousel" do
    get carousel_url(@carousel), as: :json
    assert_response :success
  end

  test "should update carousel" do
    patch carousel_url(@carousel), params: { carousel: {  } }, as: :json
    assert_response 200
  end

  test "should destroy carousel" do
    assert_difference('Carousel.count', -1) do
      delete carousel_url(@carousel), as: :json
    end

    assert_response 204
  end
end

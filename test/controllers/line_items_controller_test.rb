require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item with duplicate products" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:ruby).id }
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!

    assert_select "h2", "Your Cart"
    assert_select "td.quantity", "2"
    assert_select "td.title", "Programming Ruby 1.9"
  end

  test "should create line_item with unique products" do
    post line_items_url, params: { product_id: products(:ruby).id }
    post line_items_url, params: { product_id: products(:two).id }

    follow_redirect!

    assert_select "h2", "Your Cart"
    assert_select "td.quantity" do |elements|
      assert_equal elements.length, 2
      elements.each do |element|
        assert_equal element.text, "1"
      end
    end

    expected_titles = ["Programming Ruby 1.9", "My String 2"]
    assert_select "td.title" do |elements|
      assert_equal elements.length, 2
      elements.each_with_index do |element, index|
        assert_equal element.text, expected_titles[index]
      end
    end
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to line_items_url
  end
end

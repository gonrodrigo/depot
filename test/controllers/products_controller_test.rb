require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert_select 'h1', 'Products'
    assert_select 'table' do
      assert_select 'tr.list_line_odd', 2 do
        assert_select 'td.description' do
          assert_select 'h1', 'Programming Ruby 1.9'
          assert_select 'p', 'Ruby is the fastest growing and most exciting dynamic language out there. If ...'
        end
        assert_select 'td.image' do
          assert_select 'img', 2
        end
        assert_select 'td.actions' do
          assert_select 'ul' do
            assert_select 'li', 6
            assert_select 'li' do
              assert_select 'a', 'Show'
            end
            assert_select 'li' do
              assert_select 'a', 'Edit'
            end
            assert_select 'li' do
              assert_select 'a', 'Destroy'
            end
          end
        end
      end
    end
  end


  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @title } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "can't delete product in cart" do
    assert_difference("Product.count", 0) do
      delete product_url(products(:two))
    end

    assert_redirected_to products_url
  end
end

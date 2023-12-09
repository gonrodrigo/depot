class CombineProductsInLineItems < ActiveRecord::Migration[7.0]
  def up
    # add product price to the line items
    LineItem.all.each do |line_item|
      line_item.price = line_item.product.price * line_item.quantity
      line_item.save!
    end
  end

  def down
    # remove price from line items
    LineItem.all.each do |line_item|
      line_item.price = nil
      line_item.save!
    end
  end
end

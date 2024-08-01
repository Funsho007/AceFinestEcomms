class AddPriceAndTaxToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :product_price, :float
    add_column :order_items, :tax_rate, :float
  end
end

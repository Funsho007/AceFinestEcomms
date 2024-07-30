class AddTotalAmountToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :total_amount, :float
  end
end

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.float :total
      t.float :delivery_charges
      t.integer :status

      t.timestamps
    end
  end
end

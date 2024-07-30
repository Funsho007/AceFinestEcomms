class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.float :price, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end

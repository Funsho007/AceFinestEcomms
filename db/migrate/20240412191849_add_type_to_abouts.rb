class AddTypeToAbouts < ActiveRecord::Migration[7.0]
  def change
    add_column :abouts, :type, :string
  end
end

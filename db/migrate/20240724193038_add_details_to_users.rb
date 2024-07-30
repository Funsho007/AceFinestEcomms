class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    def change
      add_column :users, :full_name, :string unless column_exists?(:users, :full_name)
      add_column :users, :city, :string unless column_exists?(:users, :city)
      add_column :users, :postal_code, :string unless column_exists?(:users, :postal_code)
      # Don't add :address if it already existsg
  end
end
end

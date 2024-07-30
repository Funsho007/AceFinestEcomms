class AddAbbreviationToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :abbreviation, :string
  end
end

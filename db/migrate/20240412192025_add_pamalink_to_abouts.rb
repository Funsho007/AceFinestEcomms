class AddPamalinkToAbouts < ActiveRecord::Migration[7.0]
  def change
    add_column :abouts, :pamalink, :string
  end
end

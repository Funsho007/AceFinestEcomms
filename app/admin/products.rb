# app/admin/products.rb
ActiveAdmin.register Product do
  actions :index, :edit, :update, :create, :destroy, :new

  permit_params :name, :description, :price, :quantity, :product_category_id, :image, :is_featured

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :quantity
    column :product_category
    column :is_featured
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :quantity
  filter :product_category
  filter :is_featured

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price, min: 0.01, max: 999999.99
      f.input :quantity, min: 1
      f.input :product_category
      f.input :image
      f.input :is_featured
    end
    f.actions
  end
end

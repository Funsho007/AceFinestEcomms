ActiveAdmin.register Product do

  actions :index, :edit, :update, :create, :destroy, :new
  permit_params :name, :description, :price, :quantity, :image, :product_category_id, :is_featured

  filter :name
  filter :description
  filter :price
  # filter :is_featured
  filter :quantity
  filter :product_category
  filter :created_at
end

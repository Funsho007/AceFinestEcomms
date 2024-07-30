ActiveAdmin.register ProductCategory do

  actions :index, :edit, :update, :create, :destroy, :new
  permit_params :name, :description
  
end

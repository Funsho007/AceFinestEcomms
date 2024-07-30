ActiveAdmin.register Order do

filter :city_cont, label: 'City'

  actions :index, :edit, :update, :destroy
  permit_params :total, :delivery_charges, :status, :user_id, :payment_method, :address


end

class BaseController < ApplicationController
  helper_method :current_order
  before_action :assign_categories

  def current_order
    if session[:order_id].nil?
      Order.new
    else
      begin
        Order.find_by(id: session[:order_id])
      rescue ActiveRecord::RecordNotFound => e
        Order.new
      end
    end
  end

  private

  def assign_categories
    @categories = ProductCategory.where("product_categories.name is not null")
  end
end
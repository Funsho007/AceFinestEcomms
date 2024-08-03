class CartsController < BaseController
  add_breadcrumb "home", :root_path

  def show
    add_breadcrumb "products", products_path
    @order_items = current_order.try(:order_items) || []
  rescue ActiveRecord::RecordNotFound
    @order_items = []
  end

  private

  def current_order
    @current_order ||= Order.find(session[:order_id]) if session[:order_id]
    @current_order ||= Order.create(user: current_user)
  end
end

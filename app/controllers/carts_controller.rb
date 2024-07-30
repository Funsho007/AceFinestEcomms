class CartsController < BaseController

  add_breadcrumb "home", :root_path
  def show
    add_breadcrumb "products", products_path
    @order = current_order
    @order_items = current_order&.order_items
  end
end

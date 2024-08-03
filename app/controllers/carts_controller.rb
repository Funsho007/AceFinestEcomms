class CartsController < BaseController
  add_breadcrumb "home", :root_path

  def show
    add_breadcrumb "products", products_path
    @order_items = current_order.order_items
  rescue ActiveRecord::RecordNotFound
    @order_items = []
  end

  private

  def current_order
    if session[:order_id]
      begin
        @current_order = Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound
        session[:order_id] = nil
        @current_order = create_new_order
      end
    else
      @current_order = create_new_order
    end
  end

  def create_new_order
    order = Order.create(user: current_user)
    session[:order_id] = order.id
    order
  end
end

class CartsController < BaseController

 

  add_breadcrumb "home", :root_path
  def show
    add_breadcrumb "products", products_path
    def show
      add_breadcrumb "products", products_path
      @order_items = current_order.try(:order_items)
    rescue ActiveRecord::RecordNotFound
      @order_items = []
    end
  end
end

class ProductsController < BaseController
  before_action :set_current_order, only: [:show]

  add_breadcrumb "home", :root_path

  def index
    add_breadcrumb "products", products_path
    @products = Product.page(params[:page])
    @recent_products = Product.recent_products
  end

  def all_products
    @categories = ProductCategory.all
    @products = if params[:search].present?
                  Product.joins(:product_category)
                         .where("product_categories.id like ? or products.name like ?",
                                "%#{params[:category_id]}%", "%#{params[:search]}%")
                         .page(params[:page])
               else
                  Product.page(params[:page]).per(12)
               end
  end

  def recent_products
    @recent_products = Product.recent_products
  end

  def featured_products
    @featured_products = Product.featured_products
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product
      Rails.logger.debug { "Current order: #{@current_order.inspect}" }
      @order_item = @current_order.order_items.new
    else
      redirect_to products_path, alert: 'Product not found'
    end
  end

  private

  def set_current_order
    @current_order = current_order
  end
end

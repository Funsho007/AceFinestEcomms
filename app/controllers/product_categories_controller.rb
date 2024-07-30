class ProductCategoriesController < ApplicationController

  add_breadcrumb "home", :root_path
  def show
    @category = ProductCategory.find_by(id: params[:id])
    @products = Product.where(product_category: params[:id])
  end
end

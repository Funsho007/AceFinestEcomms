class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_categories
  helper_method :current_order

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      products_path
    end
  end

  def current_order
    @current_order ||= find_or_create_order
  end

  private

  def find_or_create_order
    if session[:order_id].present?
      order = Order.find_by(id: session[:order_id])
      return order if order
    end

    order = Order.create
    session[:order_id] = order.id
    order
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :address, :city, :postal_code, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :address, :city, :postal_code, :province_id])
  end

  def load_categories
    @categories = ProductCategory.all
  end
end

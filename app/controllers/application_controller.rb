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
    if session[:order_id]
      @current_order = Order.find(session[:order_id])
    else
      @current_order = Order.create(status: 'pending')
      session[:order_id] = @current_order.id
    end
  end

  private

  def find_or_create_order
    if user_signed_in?
      Order.find_or_create_by(user: current_user, status: 'pending')
    elsif session[:order_id].present?
      order = Order.find_by(id: session[:order_id], status: 'pending')
      order || create_new_order
    else
      create_new_order
    end
  end

  def create_new_order
    order = Order.create(status: 'pending')
    session[:order_id] = order.id
    order
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :city, :postal_code, :province_id, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :city, :postal_code, :province_id])
  end

  def load_categories
    @categories = ProductCategory.all
  end
end

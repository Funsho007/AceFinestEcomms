class HomeController < ApplicationController
  def index
    # if current_user&.has_role? :admin
    #   redirect_to admin_dashboard_path
    # else
      redirect_to products_path
    # end
  end

  def about
    @about = About&.last
  end

  def contact_us
    @contact = Contact.last
  end

end

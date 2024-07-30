 # frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    # Check if the submitted email and password match a regular user
    user = User.find_for_authentication(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      sign_in(:user, user)
      redirect_to products_path # Redirect to the regular user dashboard after login
    else
      # If the credentials don't match a regular user, try to authenticate as an Active Admin user
      admin_user = AdminUser.find_for_authentication(email: params[:user][:email])

      if admin_user
        # sign_in(:admin_user, admin_user)
        redirect_to new_admin_user_session_path # Redirect to the Active Admin dashboard after login
      else
        flash[:alert] = "Invalid email or password"
        # render :new
      end
    end
  end
end

class PaymentsController < BaseController
  def new
  end

  def create
    @amount = (current_order.total * 100).to_i  # Convert amount to cents as an integer

    customer = current_user.stripe_customer_id ? Stripe::Customer.retrieve(current_user.stripe_customer_id) :
      Stripe::Customer.create(email: params[:"cardholder-email"], source: params[:stripeToken])

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Stripe customer',
      currency: 'usd'
    )

    @products = current_order.products

    session[:order_id] = nil
    current_order.update(user_id: current_user.id, status: 1)

  rescue Stripe::CardError => e
    flash[:notice] = e.message
    redirect_to new_payment_path
  end
end

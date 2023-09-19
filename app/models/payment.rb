class Payment < ApplicationRecord
  belongs_to :cart_item
  def create
    # Retrieve the current customer (you may need authentication logic)
    customer = current_customer

    # Calculate the total cart amount
    total_amount = calculate_total_amount(customer.cart_items)

    # Create a Stripe PaymentIntent for the payment
    payment_intent = Stripe::PaymentIntent.create(
      amount: total_amount_in_cents, # Amount in cents
      currency: 'usd', # Replace with your preferred currency
      description: 'Payment for items in cart',
      payment_method_types: ['card'],
      customer: customer.stripe_id, # Stripe Customer ID
    )

    # Handle any Stripe errors that may occur during payment processing
    begin
      # Confirm the payment intent
      payment_intent.confirm
      # Create a Payment record to track the payment
      Payment.create(cart_items: customer.cart_items, stripe_id: payment_intent.id)
      # Clear the customer's cart (remove cart items)
      customer.cart_items.destroy_all

      render json: { message: 'Payment successful' }
    rescue Stripe::CardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue => e
      render json: { error: 'An error occurred while processing the payment' }, status: :internal_server_error
    end
  end

  private

  def calculate_total_amount(cart_items)
    # Implement logic to calculate the total amount based on cart items
    # Same logic as in CartItemsController
  end
end

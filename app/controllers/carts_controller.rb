require 'stripe'

class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /carts
  def index
    @carts = Cart.all

    render json: @carts
  end

  # GET /carts/1
  def show
    render json: @cart
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def create_stripe_session
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    cart_items = calculate_cart_items(current_user)
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: cart_items,
      mode: 'payment',
      success_url: 'http://127.0.0.1:5173/success', 
      cancel_url: 'http://127.0.0.1:5173/cancel'
    )

    render json: { session_id: session.id, payment_success: true } 
  end

  def success
    puts "SUCCESS !"
    
    current_user.cart_items.each do |current_item|
      current_user.ordered_items.create(
        item: current_item.item.name,
        price: current_item.item.price
      )

      current_user.cart_item.destroy_all
    end
    
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy
  end

  private

  def calculate_cart_items(user)
    cart_items = user.cart_items
    cart_items.map do |i|
      {
        price_data: {
          currency: 'eur',
          product_data: {
            name: i.item.name,
          },
          unit_amount: ((i.item.price * 100) + 500).to_i,
        },
        quantity: 1,
      }
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user_id)
    end
end
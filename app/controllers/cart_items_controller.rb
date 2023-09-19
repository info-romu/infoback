class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show update destroy ]


  # GET /cart_items
  def index
    if current_user
      @cart_items = current_user.cart.cart_items.includes(:item)
      render json: @cart_items.as_json(include: { item: { only: [:name, :description, :price, :imageUrl] } })
    else
      render json: { error: 'Vous devez être connecté pour accéder à votre panier' }, status: :unauthorized
    end
  end

  # GET /cart_items/1
  def show

    if @cart_item.cart.user == current_user
      render json: @cart_item.to_json(include: { item: { only: [:name, :description, :price, :imageUrl] } })
    else
      render json: { error: 'Vous n\'avez pas la permission d\'accéder à ce cart_item' }, status: :unauthorized
    end

  end

  # POST /cart_items
  def create
    @cart_item = CartItem.new(cart_item_params)

    if @cart_item.save
      render json: @cart_item, status: :created, location: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end

    # Retrieve the current customer (you may need authentication logic)
    customer = current_customer

    # Find or create a CartItem for the given item and customer
    item = Item.find(params[:item_id])
    cart_item = CartItem.find_or_create_by(item: item, customer: customer)

    # Update the quantity (if needed)
    cart_item.update(quantity: params[:quantity])

    # Calculate the total cart amount
    total_amount = calculate_total_amount(customer.cart_items)

    render json: { message: "Cart item added/updated successfully", total_amount: total_amount }
  end

  end

  # PATCH/PUT /cart_items/1
  def update
    if @cart_item.update(cart_item_params)
      render json: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cart_items/1
  def destroy
    @cart_item.destroy
    if current_user
      @cart_items = current_user.cart.cart_items.includes(:item)
      render json: @cart_items.as_json(include: { item: { only: [:name, :description, :price, :imageUrl] } })
    else
      render json: { error: 'Vous devez être connecté pour accéder à votre panier' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :item_id, :quantity)
    end

    def calculate_total_amount(cart_items)
      # Implement logic to calculate the total amount based on cart items
      total_amount = cart_items.sum { |cart_item| cart_item.item.price_cents * cart_item.quantity }
      # You can format the total_amount as needed (e.g., in cents or dollars)
      total_amount_in_cents = total_amount
      total_amount_in_dollars = total_amount / 100.0
      total_amount_in_dollars
    end
end

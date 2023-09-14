class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show update destroy ]


  # GET /cart_items
  def index
    @cart_items = CartItem.all
    
    render json: @cart_items.to_json(include: { item: { only: [:name, :description, :price, :imageUrl] } })
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
end

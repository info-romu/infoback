class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :check_admin_access, only: %i[create update destroy]

  # GET /items
  def index
    @items = Item.all

    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      @items = Item.all
      render json: { item: @item, items: @items }, status: :created, location: @Item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    @items = Item.all
    render json: @items
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :description, :price, :imageUrl)
    end

    def check_admin_access
      unless current_user && current_user.is_admin
        render json: { error: 'Vous n\'avez pas la permission d\'effectuer cette action' }, status: :unauthorized
      end
    end

end

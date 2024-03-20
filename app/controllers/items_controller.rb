class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  before_action :set_item, only: %i[show edit update destroy]
  def index
     #=> aca vamos a poner un geolocator para q aparezcan los mas cercanos primero, cool right?
    if params[:query].present?
      @items = Item.search_by_name_and_description(params[:query])
    else
      @items = Item.all
    end
  end

  def show
    @deal = Deal.new
    @offer = Offer.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def my_items
    @items = current_user.items
  end

  def edit
  end

  def update
    if @item.update(item_params[:photos] == [""] ? item_params.except(:photos) : item_params)
      redirect_to item_path(@item), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to myitems_path, status: :see_other, notice: 'Item was successfully destroyed.'
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :name, :description, :condition, photos: [])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

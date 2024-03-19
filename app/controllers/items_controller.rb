class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  before_action :set_item, only: %i[show edit update destroy]
  def index
    @items = Item.all
    # if params[:query].present?
    #   @items = Item.available.search_by_address(params[:query])
    # else
    #   @items = Item.where(available: true)
    # end

    # @markers = @items.geocoded.map do |item|
    #   {
    #     lat: item.latitude,
    #     lng: item.longitude,
    #     info_window_html: render_to_string(partial: "info_window", locals: {item: item})
    #     # marker_html: render_to_string(partial: "marker")
    #   }
    # end
  end

  def show
    @deal = Deal.new
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
      redirect_to myitems_path, status: :see_other
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

class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  # Pundit: allow-list approach
  #after_action :verify_authorized, except: :index, unless: :skip_pundit?
  #after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  before_action :set_item, only: %i[show edit update hide]

  def index
    @items = Item.where.not(user: current_user).where(hidden: false)
    # this variables help populate the items index page: recommended items based on preferences and previous deals
    @user_prefered_items = user_prefered_items if current_user.preferences.any?
    @user_recommendations = items_within_user_preferered_categories if current_user.deals.any?
    if params[:query].present? && params[:location].present?
      @items = Item.search_by_name_and_description(params[:query])
      @items = @items.near(params[:location], 20)
    elsif params[:query].present?
      @items = Item.search_by_name_and_description(params[:query])
    elsif params[:location].present?
      @items = Item.near(params[:location], 20)
      @user_prefered_items = @user_prefered_items.select { |item| item.address.downcase.include?(params[:location].downcase) || item.description.downcase.include?(params[:location].downcase) }
    elsif params[:category].present?
      @items = Item.by_category(params[:category])
    end

  end

  def my_items
    @items = current_user.items.where(hidden: false)
  end

  # Flat.near([40.71, 100.23], 20) # flats within 20 km of a point

  def show
    @reviewed_user = @item.user
    @reviews = Review.where(user_reviewed: @reviewed_user)
    @rating = @reviews.average(:rating).round(2) if @reviews.any?

    @deal = Deal.new
    @offer = Offer.new
    @chatroom = Chatroom.new

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
    @items = current_user.items.where(hidden: false)
  end

  def edit
  end

  def update
    if @item.update(item_params[:photos] == [""] ? item_params.except(:photos) : item_params)
      redirect_to item_path(@item), status: :see_other
    else
      render show.html.erb, status: :unprocessable_entity
    end
  end

  def hide
    @deals = Deal.where(status: "accepted")
    @my_deals = @deals.select { |deal| deal.user_offerer == current_user || deal.user_requested == current_user }
    @deal_with_item = @my_deals.select { |deal| deal.requested_item == @item || deal.offered_item == @item }
    if @deal_with_item.any?
      redirect_to myitems_path, status: :see_other, notice: 'No puede eliminarse un producto con trueques pendientes'
    else
      @item.update(hidden: true)
      Offer.where(offered_item: @item).update_all(status: "canceled")
      Offer.where(requested_item: @item).update_all(status: "canceled")
      redirect_to myitems_path, status: :see_other, notice: 'Producto y ofertas relacionadas canceladas'
    end
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :name, :description, :condition, :address, photos: [])
  end

  def set_item
    @item = Item.find(params[:id])
  end

    # this methods help populate the items index page: recommended items based on preferences and previous deals


  def user_prefered_items
    if current_user.preferences.any?
      preferences = current_user.preferences
      prefered_categories = []
      preferences.each do |preference|
        prefered_categories << preference.category
      end
      items = Item.where(category: prefered_categories).where.not(user: current_user).where(hidden: false)
      shuffled_items = items.shuffle
      # Select distinct items up to a maximum of 4
      item_for_user = shuffled_items.uniq.take(4)
    end
    return item_for_user
  end

  def user_interest_items
    if current_user.deals.where.not(status: "canceled").any?
      interest_items = []
      user_completed_deals = current_user.deals.where(status: "completed")
      user_completed_deals.each do |deal|
        if deal.user_offerer == current_user
          interest_items << deal.requested_item
        else
          interest_items << deal.offered_item
        end
      end
    end
    return interest_items
  end

  def user_interested_categories
    items = user_interest_items
    interested_categories = []
    items.each do |item|
      interested_categories << item.category
    end
    return interested_categories
  end

  def items_within_user_preferered_categories
    prefered_categories = user_interested_categories
    items = Item.where(category: prefered_categories).where.not(user: current_user).where(hidden: false)
    shuffled_items = items.shuffle
    # Select distinct items up to a maximum of 4
    item_for_user = shuffled_items.uniq.take(4)
    return item_for_user
  end

end

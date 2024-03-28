class OffersController < ApplicationController
  before_action :set_offer, only: %i[show edit update destroy]

  def show
    @reviewed_user = @offer.user_offerer == current_user ? @offer.user_requested : @offer.user_offerer
    @reviews = Review.where(user_reviewed: @reviewed_user)
    @rating = @reviews.average(:rating).round(2) if @reviews.any?
    @deal = Deal.new
    @chatroom = Chatroom.new
    authorize @offer
  end


  def create
    @offer = Offer.create offer_params

    if @offer.save
      redirect_to deals_path
    else
      @item = Item.find(params[:id])
      @deal = Deal.new
      @offer = Offer.new
      render 'items/show', status: :unprocessable_entity
    end
  end

  def cancel
    @offer = Offer.find(params[:id])
    @offer.update(status: 'canceled')
    redirect_to deals_path, notice: 'Oferta cancelada'
  end

  def reject
    @offer = Offer.find(params[:id])
    @offer.update(status: 'rejected')
    redirect_to deals_path, notice: 'Oferta rechazada'
  end

  def edit
  end

  def update
    @offer.update(offer_params)
  end

  def destroy
    @offer.destroy
    redirect_to items_path, status: :see_other
  end

  private

  def offer_params
    params.require(:offer).permit(:offered_item_id, :requested_item_id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

end

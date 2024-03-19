class OffersController < ApplicationController
  before_action :set_offer, only: %i[  edit update destroy]

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.save
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    @offer.update(offer_params)
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def offer_params
    params.require(:offer).permit(:offered_item_id, :requested_item_id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

end

class OffersController < ApplicationController
  before_action :set_offer, only: %i[edit update destroy]

  # there is no new action because we are creating offers from the items show page
  # def new
  #   @offer = Offer.new
  # end

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

class OffersController < ApplicationController
  before_action :set_offer, only: %i[edit update destroy]

  # there is no new action because we are creating offers from the items show page
  # def new
  #   @offer = Offer.new
  # end

  def create
    @offer = Offer.create(requested_item_id: params[:id], offered_item_id: params[:offer][:offered_item_id])

    if @offer.save
      redirect_to deals_path
    else
      render 'items/show', status: :unprocessable_entity
    end
  end

  # TODO: Implement edit and update actions i.e counteroffer
  # def edit
  # end

  # def update
  #   @offer.update(offer_params)
  # end

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

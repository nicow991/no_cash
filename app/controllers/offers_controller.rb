class OffersController < ApplicationController
  before_action :set_offer, only: %i[  edit update destroy]

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      # chatroom = Chatroom.create
      # Participant.create(user: current_user, chatroom: chatroom)
      # Participant.create(user: @offer.requested_item.id.user, chatroom: chatroom)
      # redirect_to chatroom_path(chatroom)
      redirect_to deals_path
    else
      # Handle the case where offer creation fails
      # You might want to render the form again with errors
      render :new
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
    params.require(:offer).permit(:item_id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

end

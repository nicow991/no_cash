class OffersController < ApplicationController
  before_action :set_offer, only: %i[  edit update destroy]

  def new
    @offer = Offer.new
    @item = Item.find(params[:item_id])
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.requested_item = Item.find(params[:item_id])
    @offer.user = current_user
    if @offer.save
      chatroom = Chatroom.create
      Participant.create(user: current_user, chatroom: chatroom)
      Participant.create(user: @offer.requested_item.user, chatroom: chatroom)
      redirect_to chatroom_path(chatroom)
    end
  end

  def edit
  end

  def update
    @offer.update(offer_params)
  end

  def destroy
    @offer.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def offer_params
    params.require(:offer).permit(:offered_item_id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

end

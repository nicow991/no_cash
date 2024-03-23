class DealsController < ApplicationController
  before_action :set_deal, only: %i[show cancel complete]

  def index
    @offered_offers = current_user.offered_offers.where(status: 'pending')
    @received_offers = current_user.received_offers.where(status: 'pending')

    @offered_deals = current_user.offered_deals
    @received_deals = current_user.received_deals
    @deals = @offered_deals + @received_deals
    @deal = Deal.new
  end

  def show
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.status = "accepted"
    if @deal.save
      Offer.find(@deal.offer_id).update(status: "accepted")
      redirect_to deals_path, notice: "Trueque aceptado"
    else
      render 'deals/index'
    end
  end

  def cancel
    @deal.status = "cancelled"
    @deal.save
    redirect_to deals_path
  end

  def complete
    @deal.status = "completed"
    @deal.save
    redirect_to deals_path
  end


  private

  def deal_params
  params.require(:deal).permit(:offer_id)
  end

  def set_deal
    @deal = Deal.find(params[:id])
  end
end

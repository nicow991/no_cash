class DealsController < ApplicationController
  before_action :set_deal, only: %i[show cancel]

  def index
    @my_offers = current_user.my_offers
    @received_offers = current_user.received_offers
    @offers = @my_offers + @received_offers

    @offered_deals = @my_offers.map(&:deal).compact
    @received_deals = @received_offers.map(&:deal).compact
    @deals = @offered_deals + @received_deals
    @deal = Deal.new
  end

  def show
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.status = "accepted"
    if @deal.save
      redirect_to deals_path, notice: "Trueque aceptado"
    else
      render 'deals/index'
    end
  end

  def cancel
    @deal.status = "cancelled"
    @deal.save
    redirect_to deal_path(@deal)
  end

  private

  def deal_params
  params.require(:deal).permit(:offer_id)
  end

  def set_deal
    @deal = Deal.find(params[:id])
  end
end

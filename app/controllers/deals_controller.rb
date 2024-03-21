class DealsController < ApplicationController
  before_action :set_deal, only: %i[show cancel]

  def index
    @my_offers = current_user.offers
    @received_offers = current_user.received_offers
    @offers = @my_offers + @received_offers

    @offered_deals = @my_offers.map(&:deal)
    @received_deals = @received_offers.map(&:deal)
    @deals = @offered_deals + @received_deals
  end

  def show
  end

  def create
    @deal = Deal.new
    @deal.user = current_user
    @deal.offer = Offer.find(params[:offer_id])
    if @deal.save
      redirect_to deal_path(@deal)
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

  def set_deal
    @deal = Deal.find(params[:id])
  end
end

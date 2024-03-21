class DealsController < ApplicationController
  before_action :set_deal, only: %i[show cancel]

  def index
    # Deals the current_user started and where accepted
    @offered_deals = Deal.where(user_id: current_user.id)
    # Find received deals where the current_user accepted the offer
    @received_deals = Deal.joins(:offer).where(offers: { requested_item_id: current_user.items.pluck(:id) })

    @deals = @offered_deals + @received_deals

    # Offers the current_user did
    @my_offers = Offer.where(user_id: current_user.id)

    # Find received offers by the current_user
    @received_offers = Offer.where(requested_item_id: current_user.items.pluck(:id))

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

class DealsController < ApplicationController
  before_action :set_deal, only: %i[show cancel]

  def index
    @deals = Deal.where(offer_id: current_user.id)
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

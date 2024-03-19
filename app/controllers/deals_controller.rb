class DealsController < ApplicationController
  before_action :set_deal, only: %i[show cancel]

  def index
    @deals = current_user.deals
  end

  def show
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.user = current_user
    @deal.offer = Offer.find(params[:offer_id])
    @deal.status = "pending"
    if @deal.save
      redirect_to deals_path
    else
      render 'deals/index'
    end
  end

  def cancel
    @deal.status = "cancelled"
    @deal.save
    redirect_to deals_path
  end


  private

  def deal_params
    params.require(:deal).permit(:status)
  end

  def set_deal
    @deal = Deal.find(params[:id])
  end
end

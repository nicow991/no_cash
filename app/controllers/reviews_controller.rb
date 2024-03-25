class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @deal = Deal.find(params[:deal_id])
    @review.deal = @deal
    @reviewed_user = @deal.user_offerer == current_user ? @deal.user_requested : @deal.user_offerer
    @review.user_reviewed = @reviewed_user
    @review.user_reviewer = current_user
    if @review.save
      redirect_to deal_path(@deal), notice: 'Reseña creada'
    else
      @offered_offers = current_user.offered_offers.where(status: 'pending')
      @received_offers = current_user.received_offers.where(status: 'pending')

      @offered_deals = current_user.offered_deals
      @received_deals = current_user.received_deals
      @deals = @offered_deals + @received_deals
      @deal = Deal.new
      # @review = Review.new
      @accepted_deals = filter_deals('accepted')
      @completed_deals = filter_deals('completed')
      @canceled_deals = filter_deals('canceled')
      @errors = @review.errors.full_messages

      render 'deals/index', status: :unprocessable_entity
    end
  end

  def filter_deals(status)
    @deals.select { |deal| deal.status == status }
  end
  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

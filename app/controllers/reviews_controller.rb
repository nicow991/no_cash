class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.deal = Deal.find(params[:deal_id])
    @review.user = current_user
    @review.save
    redirect_to deal_path(@review.deal)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end

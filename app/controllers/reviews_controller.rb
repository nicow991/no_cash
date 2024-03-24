class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @deal = Deal.find(params[:deal_id])
    @review.deal = @deal
    @reviewed_user = @deal.user_offerer == current_user ? @deal.user_requested : @deal.user_offerer
    @review.user_reviewed = @reviewed_user
    @review.user_reviewer = current_user

    if @review.save
      redirect_to deals_path, notice: 'Reseña creada'
    else
      render 'deals/index', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

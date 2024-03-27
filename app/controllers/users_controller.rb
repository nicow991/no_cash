class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_reviewed: @user)
    @rating = @reviews.average(:rating).round(2) if @reviews.any?

  end

  def profile
    @user = current_user
    @preference = Preference.new
    @reviews = Review.where(user_reviewed: @user)
    @rating = @reviews.average(:rating).round(2) if @reviews.any?
  end

end

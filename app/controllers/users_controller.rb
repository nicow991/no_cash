class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :create]
  def show
    @user = User.find(params[:id])
    @items = Item.where(user: @user, hidden: false)
    @reviews = Review.where(user_reviewed: @user)
    @rating = @reviews.average(:rating).round(2) if @reviews.any?

  end

  def profile
    @user = current_user
    @items = Item.where(user: @user, hidden: false)
    @preference = Preference.new
    @reviews = Review.where(user_reviewed: @user)
    @rating = @reviews.average(:rating).round(2) if @reviews.any?
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      choose_preferences = params[:user][:preference_ids]&.to_a&.tap(&:shift)
      if choose_preferences.present?
        choose_preferences.each do |id|
          Preference.create!(category_id: id, user: @user)
        end
      end

      sign_in(@user) # Sign in the user after successful registration


      redirect_to items_path
    else
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :address, :nickname)
  end

end

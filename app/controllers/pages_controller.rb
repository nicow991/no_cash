class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    redirect_to '/items' if user_signed_in?
  end
end

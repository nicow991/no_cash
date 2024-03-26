class UsersController < ApplicationController

  def show
    @user = current_user
    @preference = Preference.new
  end

end

class PreferencesController < ApplicationController
  def create
    raise
    @preference = Preference.new(preference_params)

    @preference.user = current_user
    if @preference.save
      redirect_to user_path(current_user)
    else
      render 'users/show'
    end
  end

  private

  def preference_params
    params.require(:preference).permit(:category_id)
  end
end

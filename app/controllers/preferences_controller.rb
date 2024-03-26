class PreferencesController < ApplicationController
  def create
    @preference = Preference.new(category: Category.find(params[:category_id]), user: current_user)
    if @preference.save
      redirect_to profile_path(current_user)
    else
      render 'users/show'
    end
  end

  def destroy
    @preference = Preference.find(params[:id])
    @preference.destroy
    redirect_to profile_path(current_user), status: :see_other, notice: 'Tu preferencia se ha eliminado'
  end

end

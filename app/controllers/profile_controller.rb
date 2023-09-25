class ProfileController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @profile = User.find(params[:id])

    if @profile.id == current_user.id
      render json: @profile
    else
      render json: { error: "Vous n'êtes pas autorisé à afficher ce profil." }, status: :unauthorized
    end
  end
end
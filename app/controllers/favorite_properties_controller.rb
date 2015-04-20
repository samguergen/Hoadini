class FavoritePropertiesController < ApplicationController

	def create
		FavoriteProperty.create(favorite_properties_params)
    redirect_to '/properties'
	end

	def index
		@properties = FavoriteProperty.where(user_id: session[:user_id])
	end

  private

  def favorite_properties_params
     params.require(:favorite_properties).permit(:z_id, :address, :rating, :price, :picture, :title).merge(:user => current_user)
  end

end

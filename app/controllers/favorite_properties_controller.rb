class FavoritePropertiesController < ApplicationController

	def create
		FavoriteProperty.create(favorite_properties_params)
    redirect_to '/properties'
	end

	def show
		@properties = FavoriteProperty.where(user_id: params)
	end

  private

  def favorite_properties_params
    p "PARAMS: #{params}"
     params.require(:favorite_properties).permit(:address, :rating, :price, :picture, :title).merge(:user => current_user)
  end

end

class FavoritePropertiesController < ApplicationController

	def create
		FavoriteProperty.create(params)
	end

	def show
		@properties = FavoriteProperty.where(user_id: params)
	end
end
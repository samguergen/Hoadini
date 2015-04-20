class FavoritePropertiesController < ApplicationController

	def create
		FavoriteProperty.create(params)
	end

	def index
		@properties = FavoriteProperty.where(user_id: session[:user_id])
	end
end
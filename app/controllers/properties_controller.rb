class PropertiesController < ApplicationController

	def index
		@properties = FavoriteProperty.where(user_id: session[:user_id])
	end

	def show

	end
end
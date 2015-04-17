class PropertiesController < ApplicationController

	def index
		@properties = FavoriteProperty.where(user_id: params)
	end

	def show

	end
end
class PropertiesController < ApplicationController

	def index
		@properties = FavoriteProperty.all
	end

	def show

	end
end
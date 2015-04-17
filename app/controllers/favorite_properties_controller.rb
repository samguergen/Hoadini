class SessionsController < ApplicationController

	def create
		FavoriteProperty.create(params)
	end

	def show
		@properties = FavoriteProperty.where(user_id: session[:user_id])
	end
end
class UsersController < ApplicationController











def show
	@user = User.find_by(id: session[:user_id])
	@properties = Favorite_property.where(user_id: session:[user_id])
end

end
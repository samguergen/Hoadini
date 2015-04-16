class UsersController < ApplicationController











def show
	#@user = User.find_by(id: session[:user_id])
	@properties = Favorite_property.where(user_id: session:[user_id])
	@user = User.create(email: 'kevalwell@gmail.com', avatar: '/https://avatars0.githubusercontent.com/u/8462375?v=3&s=460', password_digest: '123',first_name:'kevin', last_name: 'alwell', gender: 'Male', age: 22 )
end

end
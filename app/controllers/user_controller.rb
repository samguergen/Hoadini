











def show
	#@user = User.find_by(id: session[:user_id])
	@user = User.create(first_name:'kevin', last_name: 'alwell', gender: 'Male', age: 22 )
end
class UsersController < ApplicationController


  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect to '/signup'
    end
   end

	def show
		@user = User.find_by(id: session[:user_id])
		@properties = FavoriteProperty.where(user_id: @user.id)
	end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :age, :gender)
  end
 end

class UserPreferencesController < ApplicationController

  def index
    @user_prefs = UserPreference.all
  end


  def show
    @user_pref = UserPreference.find_by(id: params[:id])
  end


  def new
    @new_user_pref = UserPreference.new
  end


  def create
    if session[:user_id]
      @new_user_pref = UserPreference.new(userpref_params)
      redirect_to root_path
    else
      flash[:notice] = "You must be a member to add your preference!"
      redirect_to new_userpreference_path
    end
  end


  def edit
    @user_pref = UserPreference.find_by(id: params[:id])
  end


  def update
    @user_pref = UserPreference.find_by(id: params[:id])
    if session[:user_id] == @user_pref.user_id
      @user_pref.update_attributes(edit_userpref_params)
      redirect_to root_path
    else
      flash[:notice] = "You cannot edit these criteria"
      redirect_to edit_userpreference_path
    end
  end


  def destroy
    @user_pref = UserPreference.find_by(id: params[:id])
    if session[:user_id] == @user_pref.user_id
      @user_pref.destroy!
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


private

  def userpref_params
    params.require(:userpreference).permit(:criterium_id, :score).merge(:user_id)
  end


end

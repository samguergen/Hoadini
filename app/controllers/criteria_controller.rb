class CriteriaController < ApplicationController

  def index
    @criteria = Criterium.all
  end

  def show
    @criterium = Criterium.find_by(id: params[:id])
  end


  def new
    @new_criterium = Criterium.new
  end


  def create
    if session[:user_id]
      @new_criterium = Criterium.new(criterium_params)
      redirect_to root_path
    else
      flash[:notice] = "You must be a member to add criteria!"
      redirect_to new_criterium_path
    end
  end


  def edit
    @criterium = Criterium.find_by(id: params[:id])
  end


  def update
    @criterium = Criterium.find_by(id: params[:id])
    if session[:user_id] == @criterium.user_id
      @criterum.update_attributes(criterium_params)
      redirect_to root_path
    else
      flash[:notice] = "You cannot edit these criteria"
      redirect_to edit_criterium_path
    end
  end


  def destroy

  end


private

  def criterium_params
    params.require(:criterium).permit(:description, :kind, :api_url)
  end

end

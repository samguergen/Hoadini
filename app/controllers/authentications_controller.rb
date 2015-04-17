class AuthenticationsController < ApplicationController
  before_action :current_user
  before_action :set_authentication, only: [:show, :edit, :update, :destroy]

  # GET /authentications
  # GET /authentications.json
  def index
    @authentications = Authentication.all
  end

  # GET /authentications/new
  def new
    @authentication = Authentication.new
  end

  # POST /authentications
  # POST /authentications.json
  def create
    #render :text => request.env["omniauth.auth"].to_yaml

    auth = request.env["omniauth.auth"]
    current_user.authentications.create(:provider => auth['provider'], :uid => auth['uid'])
    # flash[:notice] = "Authentication Successful"
    redirect_to authentication_url
    # @authentication = Authentication.new(authentication_params)

    # respond_to do |format|
    #   if @authentication.save
    #     format.html { redirect_to @authentication, notice: 'Authentication was successfully created.' }
    #     format.json { render :show, status: :created, location: @authentication }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @authentication.errors, status: :unprocessable_entity }
    #   end
    # end
  end


  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication.destroy
    respond_to do |format|
      format.html { redirect_to authentications_url, notice: 'Authentication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authentication
      @authentication = Authentication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authentication_params
      params.require(:authentication).permit(:user_id, :provider, :uid)
    end
end

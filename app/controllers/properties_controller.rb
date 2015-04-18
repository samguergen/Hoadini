class PropertiesController < ApplicationController

	def index
		@properties = FavoriteProperty.all
	end

	def show

	end

  def list
    @list = HTTParty.get('https://zilyo.p.mashape.com/search',
                      {query: {nelatitude: params[:nelatitude],
                               nelongitude: params[:nelongitude],
                               swlatitude: params[:swlatitude],
                               swlongitude: params[:swlongitude],
                               isinstantbook: 'true',
                               provider: 'airbnb,housetrip'},
                       headers: {'X-Mashape-Key' => 'Aq8RN3VWDnmshWqAaThekfgTPEbap1a3Tn3jsnBYV3fjrNDyQZ'}})
  end
end
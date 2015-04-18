class PropertiesController < ApplicationController

	def index
		@properties = FavoriteProperty.all
	end

	def show
	end

  def find_property
    @z = HTTParty.get('https://zilyo.p.mashape.com/search',
                      {query: {nelatitude: '22.37',
                               nelongitude: '-154.48000000000002',
                               swlatitude: '18.55',
                               swlongitude: '-160.52999999999997',
                               isinstantbook: 'true',
                               provider: 'airbnb,housetrip'},
                       headers: {'X-Mashape-Key' => 'Aq8RN3VWDnmshWqAaThekfgTPEbap1a3Tn3jsnBYV3fjrNDyQZ'}})
  end
end
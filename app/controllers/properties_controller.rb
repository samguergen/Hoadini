class PropertiesController < ApplicationController

	def index
		@properties = FavoriteProperty.all
	end

	def show
    #
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

  def crime
    # get URL is the api call up until the '?' for proceeding params
    @crime = HTTParty.get('http://api.spotcrime.com/crimes.json',
    # take from params on URL
                      { query: { lat: params[:lat],
                                 lon: params[:lon],
                                 key: params[:key],
                                 radius: params[:radius]}
                      })
    # will count the number of crimes within the radius of the location via results as shown through properties/crime.html.erb
  end

  def yummy
    @yelp = HTTParty.get('http://api.yelp.com/v2/business',
                      {query: {distance: params[:distance],
                               location: params[:location],
                               name: params[:name]}
                      })
  end
end
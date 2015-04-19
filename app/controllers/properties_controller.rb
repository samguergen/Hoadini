class PropertiesController < ApplicationController

	def index
		@properties = FavoriteProperty.all
	end

	def show
    @property = HTTParty.get('https://zilyo.p.mashape.com/id',
                    {query: {id: params[:id]},
                     headers: {'X-Mashape-Key' => 'Aq8RN3VWDnmshWqAaThekfgTPEbap1a3Tn3jsnBYV3fjrNDyQZ'}
                    })

    @property_hash = JSON.parse(@property.body)
# ?id=air1158977
	end

  def list
    @list = JSON.parse(HTTParty.get('https://zilyo.p.mashape.com/search',
                                    {query: {nelatitude: params[:nelatitude],
                                             nelongitude: params[:nelongitude],
                                             swlatitude: params[:swlatitude],
                                             swlongitude: params[:swlongitude],
                                             isinstantbook: 'true',
                                             provider: 'airbnb,housetrip'},
                                     headers: {'X-Mashape-Key' => 'Aq8RN3VWDnmshWqAaThekfgTPEbap1a3Tn3jsnBYV3fjrNDyQZ'}}).body)
#     @list['result'].each do |r|
#       r['calc'] = 100#[1..100].sample
# #      @crime = JSON.parse(crime(params[:nelatitude], params[:nelongitude], 5).body)
#     end
#     @list['result'].each do |r|
#       p r['calc']
#     end
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


  private

  def crime(lat, lon, radius)
    # get URL is the api call up until the '?' for proceeding params
    @crime = HTTParty.get('http://api.spotcrime.com/crimes.json',
    # take from params on URL
                      { query: { lat: lat,
                                 lon: lon,
                                 key: 'MLC-restricted-key',
                                 radius: radius}
                      })
    # will count the number of crimes within the radius of the location via results as shown through properties/crime.html.erb
  end

end
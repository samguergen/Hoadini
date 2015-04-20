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
    list = JSON.parse(HTTParty.get('https://zilyo.p.mashape.com/search',
                                    {query: {nelatitude: params[:nelatitude],
                                             nelongitude: params[:nelongitude],
                                             swlatitude: params[:swlatitude],
                                             swlongitude: params[:swlongitude]},
                                     headers: {'X-Mashape-Key' => 'Aq8RN3VWDnmshWqAaThekfgTPEbap1a3Tn3jsnBYV3fjrNDyQZ'}}).body)

    # save each score into each result
    list['result'].each do |r|
      crime = JSON.parse(crime(r['latLng'][0], r['latLng'][1], 0.5).body)
      r['calc'] = crime['crimes'].count
    end

    top_list = list['result'].sort {|x,y| y['calc']<=>x['calc']}[0..2]

    render json: top_list
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

  def yelp_distance_subway
    # this is just to setup the connection
    subway = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    params = { term: 'public transportation',
               limit: 4
             }

    coordinates = { latitude: params[], longitude: params[] }
    @subways = subway.search_by_coordinates(coordinates, params)

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

  private

    def yelp_distance_museum(lat, lon, radius)
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

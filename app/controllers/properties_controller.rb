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
      UserPreference.get_user_pref(current_user).each do |pref|
        case pref.criterium.description
        when 'museum'
          # type museum
        when 'park'
          # type park
        when 'price'
          # price range per day
        when 'crime'
          # less is better
          # get crime in a 0.05 miles radius

          crime = JSON.parse(crime_call(r['latLng'][0], r['latLng'][1], 0.05).body)
          r['crimes'] = crime['crimes']
        when 'food'
          # type food
        when 'subway station'
          # distance to closest subway
        end
      end
    end

    top_list = list['result'].sort {|x,y| x['crimes'].count<=>y['crimes'].count}[0..2]

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

    query = { term: 'subway',
              category_filter: 'publictransport',
              limit: 4
            }

    coordinates = { latitude: params[:latitude],
                    longitude: params[:longitude] }

    @subways = subway.search_by_coordinates(coordinates, query).businesses.sort {|x,y| x.distance <=> y.distance}

  end

  def yelp_distance_museum
    # get URL is the api call up until the '?' for proceeding params
    museum = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = { term: 'museums',
               limit: 4,
               sort: 1
             }

    coordinates = { latitude: params[:lat], longitude: params[:lon] }
    @museums = museum.search_by_coordinates(coordinates, query)
  end

  def yelp_distance_food
    # get URL is the api call up until the '?' for proceeding params
    food = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                              consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                              token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                              token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                            })

    query = { term: 'mexican',
              category_filter: 'food',
              limit: 6,
              sort: 1
             }

    coordinates = { latitude: params[:lat],
                    longitude: params[:lon] }
    @foods = food.search_by_coordinates(coordinates, query)
  end

  def yelp_distance_park
    # get URL is the api call up until the '?' for proceeding params
    park = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                              consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                              token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                              token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                            })

    query = { term: 'park',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: params[:lat], longitude: params[:lon] }
    @parks = park.search_by_coordin
                  tes(coordinates, query)
  end

  def yelp_distance_museum
    # get URL is the api call up until the '?' for proceeding params
    museum = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = { term: 'museums',
               limit: 4,
               sort: 1
             }

    coordinates = { latitude: params[:lat],
                    longitude: params[:lon] }
    @museums = museum.search_by_coordin
                  tes(coordinates, query)
  end

  def yelp_distance_food
    # get URL is the api call up until the '?' for proceeding params
    food = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = { term: 'food',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: params[:lat],
                    longitude: params[:lon] }
    @foods = food.search_by_coordin
                  tes(coordinates, query)
  end

  def yelp_distance_park
    # get URL is the api call up until the '?' for proceeding params
    park = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = { term: 'park',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: params[:lat],
                    longitude: params[:lon] }
    @parks = park.search_by_coordin
                  tes(coordinates, query)
  end


  def yelp_distance_landmark
    # get URL is the api call up until the '?' for proceeding params
    landmark = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = { term: 'landmark',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: params[:lat],
                    longitude: params[:lon] }
    @landmarks = landmark.search_by_coordinates(coordinates, query)
  end


  def yelp_distance_shopping
    # get URL is the api call up until the '?' for proceeding params
    shopping = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = { term: 'shopping',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: params[:lat],
                    longitude: params[:lon] }
    @shops = shopping.search_by_coordinates(coordinates, query)
  end

  private

  def crime_call(lat, lon, radius)
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

  def yelp_distance_subway_call(lat, lon)
    # this is just to setup the connection
    subway = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                              })

    params = { term: 'subway',
               category_filter: 'public transport',
               limit: 4
             }

    coordinates = { latitude: lat,
                    longitude: lon }

    @subways = subway.search_by_coordinates(coordinates, params).businesses.sort {|x,y| x.distance <=> y.distance}

  end

  def yelp_distance_museum_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    museum = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = { term: 'museums',
               limit: 4,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lon }
    @museums = museum.search_by_coordinates(coordinates, query)
  end

  def yelp_distance_food_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    food = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                              consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                              token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                              token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                            })

    params = { term: 'mexican',
              category_filter: 'food',
              limit: 6,
              sort: 1
             }

    coordinates = { latitude: lat, longitude: lon }
    @foods = food.search_by_coordinates(coordinates, params)
  end

  def yelp_distance_park_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    park = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                              consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                              token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                              token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                            })

    params = { term: 'park',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lon }
    @parks = park.search_by_coordinates(coordinates, params)
  end

  def yelp_distance_museum_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    museum = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    params = { term: 'museums',
               limit: 4,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lon }
    @museums = museum.search_by_coordinates(coordinates, params)
  end

  def yelp_distance_food_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    food = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    params = { term: 'food',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lon }
    @foods = food.search_by_coordinates(coordinates, params)
  end

  def yelp_distance_park_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    park = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    params = { term: 'park',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lon }
    @parks = park.search_by_coordinates(coordinates, params)
  end


  def yelp_distance_landmark_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    landmark = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    params = { term: 'landmark',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lon }
    @landmarks = landmark.search_by_coordinates(coordinates, params)
  end


  def yelp_distance_shopping_call(lat, lon)
    # get URL is the api call up until the '?' for proceeding params
    shopping = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    params = { term: 'shopping',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lon }
    @shops = shopping.search_by_coordinates(coordinates, params)
  end

end

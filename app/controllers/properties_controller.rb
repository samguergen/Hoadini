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

    # p "prop hash: #{@property_hash['result']}"

    lat = @property_hash['result']['latLng'][0]
    lng = @property_hash['result']['latLng'][1]
    UserPreference.get_user_pref(current_user).each do |pref|
      case pref.criterium.description
      when 'museum'
        # type museum
        m = yelp_distance_museum_call(lat, lng, pref.search)
        # put in list of businesses into each property
        @property_hash['museums'] = m
      when 'park'
        # type park
        p = yelp_distance_park_call(lat, lng, pref.search)
        # put in list of businesses into each property
        @property_hash['parks'] = p
      when 'price'
        # price range per day

        @property_hash['prices'] = []
      when 'crime'
        # less is better
        # get crime in a 0.05 miles radius

        crime = JSON.parse(crime_call(lat, lng, 0.05).body)
        @property_hash['crimes'] = crime['crimes']
      when 'food'
        # type food
        #  pref.search is the search box on the criteria
        f = yelp_distance_food_call(lat, lng, pref.search)
        # put in list of businesses into each property
        @property_hash['foods'] = f
      when 'subway station'
        # distance to closest subway
        sub = yelp_distance_subway_call(lat, lng, pref.search)
        # put in list of businesses into each property
        @property_hash['subways'] = sub
      when 'landmark'
        # distance to landmark
        l = yelp_distance_landmark_call(lat, lng, pref.search)

        @property_hash['landmarks'] = l
      when 'shopping'
        # distance to shopping
        shop = yelp_distance_shopping_call(lat, lng, pref.search)

        @property_hash['shops'] = shop
      end
    end
#example ?id=air1158977
  end

  def list
    list = JSON.parse(HTTParty.get('https://zilyo.p.mashape.com/search',
                                    {query: {nelatitude: params[:nelatitude],
                                             nelongitude: params[:nelongitude],
                                             swlatitude: params[:swlatitude],
                                             swlongitude: params[:swlongitude]},
                                     headers: {'X-Mashape-Key' => 'Aq8RN3VWDnmshWqAaThekfgTPEbap1a3Tn3jsnBYV3fjrNDyQZ'}}).body)

    # save each json into each result for calculation
    list['result'].each do |r|
      lat = r['latLng'][0]
      lng = r['latLng'][1]
      UserPreference.get_user_pref(current_user).each do |pref|
        case pref.criterium.description
        when 'museum'
          # type museum
          m = yelp_distance_museum_call(lat, lng, pref.search)
          # put in list of businesses into each property
          r['museums'] = m
        when 'park'
          # type park
          p = yelp_distance_park_call(lat, lng, pref.search)
          # put in list of businesses into each property
          r['parks'] = p
        when 'price'
          # price range per day

          r['prices'] = []
        when 'crime'
          # less is better
          # get crime in a 0.05 miles radius

          crime = JSON.parse(crime_call(lat, lng, 0.05).body)
          r['crimes'] = crime['crimes']
        when 'food'
          # type food
          #  pref.search is the search box on the criteria
          f = yelp_distance_food_call(lat, lng, pref.search)
          # put in list of businesses into each property
          r['foods'] = f
        when 'subway station'
          # distance to closest subway
          sub = yelp_distance_subway_call(lat, lng, pref.search)
          # put in list of businesses into each property
          r['subways'] = sub
        when 'landmark'
          # distance to landmark
          l = yelp_distance_landmark_call(lat, lng, pref.search)

          r['landmarks'] = l
        when 'shopping'
          # distance to shopping
          shop = yelp_distance_shopping_call(lat, lng, pref.search)

          r['shops'] = shop
        end
      end
    end

    # sort later .sort {|x,y| y['calc']<=>x['calc']}
    top_list = list['result'][0..7]

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

    query = { term: 'subway ' + params[:term],
              category_filter: 'publictransport',
              limit: 4
            }

    coordinates = { latitude: params[:latitude],
                    longitude: params[:longitude] }

    @subways = subway.search_by_coordinates(coordinates, query)

  end

  def yelp_distance_museum
    # get URL is the api call up until the '?' for proceeding params
    museum = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = {  term: params[:term],
               category_filter: 'museums',
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

    query = { term: params[:term],
              category_filter: 'food',
              radius_filter: 0.5,
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

    query = {  term: params[:term],
               category_filter: 'parks, amusementparks',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: params[:lat], longitude: params[:lon] }
    @parks = park.search_by_coordinates(coordinates, query)
  end

  def yelp_distance_landmark
    # get URL is the api call up until the '?' for proceeding params
    landmark = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = {  term: params[:term],
               category_filter: 'landmarks',
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

    query = { term: params[:term],
               category_filter: 'shopping',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: params[:lat],
                    longitude: params[:lon] }
    @shops = shopping.search_by_coordinates(coordinates, query)
  end

 private

  def crime_call(lat, lng, radius)
    # get URL is the api call up until the '?' for proceeding params
    @crime = HTTParty.get('http://api.spotcrime.com/crimes.json',
    # take from params on URL
                      { query: { lat: lat,
                                 lon: lng,
                                 key: 'MLC-restricted-key',
                                 radius: radius}
                      })
    # will count the number of crimes within the radius of the location via results as shown through properties/crime.html.erb
  end

  def yelp_distance_subway_call(lat, lng, term = '')
    # this is just to setup the connection
    subway = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                              })

    params = { term: 'subway ' + term,
               category_filter: 'public transport',
               radius_filter: 1,
               limit: 4
             }

    coordinates = { latitude: lat,
                    longitude: lng }

    subways = subway.search_by_coordinates(coordinates, params).businesses.sort {|x,y| x.distance <=> y.distance}

  end

  def yelp_distance_museum_call(lat, lng, term = '')
    # get URL is the api call up until the '?' for proceeding params
    museum = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                          })

    query = {  term: term,
               category_filter: 'museums',
               limit: 4,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lng }

    museums = museum.search_by_coordinates(coordinates, query).businesses.sort {|x,y| x.distance <=> y.distance}
  end

  def yelp_distance_food_call(lat, lng, term = '')
    # get URL is the api call up until the '?' for proceeding params
    food = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                              consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                              token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                              token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                            })

    query = { term: term,
              category_filter: 'food',
              radius_filter: 0.5,
              limit: 6,
              sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lng }

    foods = food.search_by_coordinates(coordinates, query).businesses.sort {|x,y| x.distance <=> y.distance}
  end

  def yelp_distance_park_call(lat, lng, term = '')
    # get URL is the api call up until the '?' for proceeding params
    park = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                              consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                              token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                              token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                            })

    query = {  term: term,
               category_filter: 'parks',
               limit: 4,
               radius_filter: 0.5,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lng }

    parks = park.search_by_coordinates(coordinates, query).businesses.sort {|x,y| x.distance <=> y.distance}

  end

  def yelp_distance_landmark_call(lat, lng, term = '')
    # get URL is the api call up until the '?' for proceeding params
    landmark = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                                })

    query = {  term: term,
               category_filter: 'landmarks',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lng }
    landmarks = landmark.search_by_coordinates(coordinates, query).businesses.sort {|x,y| x.distance <=> y.distance}
  end

  def yelp_distance_shopping_call(lat, lng, term = '')
    # get URL is the api call up until the '?' for proceeding params
    shopping = Yelp::Client.new({ consumer_key: 'UY_Ov3aMEcbjqLLvnZ1Qfw',
                                     consumer_secret: 'nyuOcG7kvFI83aeiAxg2PA5w6tU',
                                     token: 'F0xUFQo9Tu6yTHtFli-8Ds-jxLHlLjYs',
                                     token_secret: 'o_UfHL_LzaTu12UlPmw3vft-o-c'
                               })

    query = { term: term,
               category_filter: 'shopping',
               limit: 6,
               sort: 1
             }

    coordinates = { latitude: lat,
                    longitude: lng }
    shops = shopping.search_by_coordinates(coordinates, query).businesses.sort {|x,y| x.distance <=> y.distance}
  end
end

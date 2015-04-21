#add user photo url/upload in migration and seed?

sam = {name: 'sam'}
trace = {name: 'tracy'}
hoa = {name: "Hoa The Nguyen", oauth_token: "ya29.WQFBIVWv1qLnIV9vr3s3qs92ONddMLLMv6ck3zFpKpWfn...", provider: "google_oauth2", uid: "109918401376962043632", oauth_expires_at: "2015-04-18 17:08:22 -0400"}
kev = {name: 'Kevin Alwell', provider: "google_oauth2", uid: "108795988358950162237", oauth_token: "ya29.WQHstYEa6BsftTS7Y68yaZN_Sh0AnUfajx_6ZT6eabmYh...", provider: "google_oauth2", uid: "108795988358950162237", oauth_expires_at: "2015-04-18 16:44:50 -0400"}

samsam = User.create(sam)
tracetrace = User.create(trace)
hoahoa = User.create(hoa)
kevkev = User.create(kev)


# prop1 = {address: "50 E 28th St, New York, NY 10016", rating: 9, user_id: samsam.id, title: 'Beautiful Apartment', description: 'beautiful apartment that overlooks the city, lots of people around all the damyummnyum time.'}
# prop2 = {address: "101 W End Ave, New York, NY 10023", rating: 8, user_id: tracetrace.id, title: 'Beautiful Apartment', description: 'beautiful apartment that overlooks the city, lots of people around all the damyummnyum time.'}
# prop3 = {address: "1 Stuyvesant Oval, New York, NY 10009", rating: 7, user_id: hoahoa.id, title: 'Beautiful Apartment', description: 'beautiful apartment that overlooks the city, lots of people around all the damyummnyum time.'}
# prop4 = {address: "515 W 52nd St, New York, NY 10019", rating: 10, user_id: tracetrace.id, title: 'Beautiful Apartment', description: 'beautiful apartment that overlooks the city, lots of people around all the damyummnyum time.'}
# prop5 = {address: "11 E 1st St, New York, NY 10003", rating: 8, user_id: kevkev.id, title: 'Beautiful Apartment', description: 'beautiful apartment that overlooks the city, lots of people around all the damyummnyum time.'}
# prop6 = {address: "105 W 29th St, New York, NY 10001", rating: 9, user_id: samsam.id, title: 'Beautiful Apartment', description: 'beautiful apartment that overlooks the city, lots of people around all the damyummnyum time.'}

# prop_1 = FavoriteProperty.create(prop1)
# prop_2 = FavoriteProperty.create(prop2)
# prop_3 = FavoriteProperty.create(prop3)
# prop_4 = FavoriteProperty.create(prop4)
# prop_5 = FavoriteProperty.create(prop5)
# prop_6 = FavoriteProperty.create(prop6)

#kind is rating or distance
crit1 = {description: "museum", kind: "distance", api_url: "http://api.yelp.com/v2/search", has_search: true}
crit2 = {description: "landmark", kind: "distance", api_url: "http://api.yelp.com/v2/search", has_search: true}
crit3 = {description: "park", kind: "distance", api_url: "http://api.yelp.com/v2/search", has_search: true}
crit4 = {description: "shopping", kind: "distance", api_url: "http://api.yelp.com/v2/search", has_search: true}
crit5 = {description: "price", kind: "rating", api_url: "http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm", has_search: true}
crit6 = {description: "crime", kind: "rating", api_url: "http://api.spotcrime.com/crimes.json", has_search: false}
crit7 = {description: "food", kind: "distance", api_url: "http://api.yelp.com/v2/search", has_search: true}
crit8 = {description: "subway station", kind: "distance", api_url: "http://api.yelp.com/v2/search", has_search: false}


crit_1 = Criterium.create(crit1)
crit_2 = Criterium.create(crit2)
crit_3 = Criterium.create(crit3)
crit_4 = Criterium.create(crit4)
crit_5 = Criterium.create(crit5)
crit_6 = Criterium.create(crit6)
crit_7 = Criterium.create(crit7)
crit_8 = Criterium.create(crit8)

upref1 = {score: 9, user_id: samsam.id, criterium_id: crit_1.id }
upref2 = {score: 10, user_id: tracetrace.id, criterium_id: crit_2.id }
upref3 = {score: 7, user_id: hoahoa.id, criterium_id: crit_3.id  }
upref4 = {score: 7, user_id: kevkev.id , criterium_id: crit_4.id }
upref5 = {score: 9, user_id: hoahoa.id, criterium_id: crit_5.id }
upref6 = {score: 10, user_id: samsam.id, criterium_id: crit_6.id }
upref7 = {score: 6, user_id: tracetrace.id, criterium_id: crit_7.id }

upref_1 = UserPreference.create(upref1)
upref_2 = UserPreference.create(upref2)
upref_3 = UserPreference.create(upref3)
upref_4 = UserPreference.create(upref4)
upref_5 = UserPreference.create(upref5)
upref_6 = UserPreference.create(upref6)
upref_7 = UserPreference.create(upref7)




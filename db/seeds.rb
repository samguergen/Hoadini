#add user photo url/upload in migration and seed?

sam = {email: sam@gmail.com, password:"1212", password_confirmation: "1212", first_name: "Samantha", last_name: "Guergenenov", gender: "F", age: 24}
trace = {email: tracy@gmail.com, password:"2323", password_confirmation: "2323", first_name: "Tracy", last_name: "Teague", gender: "F", age: 24}
hoa = {email: hoa@gmail.com, password:"3434", password_confirmation: "3434", first_name: "Hoa", last_name: "Nguyen", gender: "M", age: 29}
kev = {email: kevin@gmail.com, password:"4545", password_confirmation: "4545", first_name: "Kevin", last_name: "Alwell", gender: "M", age: 17}

samsam = User.create(sam)
tracetrace = User.create(trace)
hoahoa = User.create(hoa)
kevkev = User.create(kev)


prop1 = {address: "50 E 28th St, New York, NY 10016", rating: 9, user_id: samsam.id}
prop2 = {address: "101 W End Ave, New York, NY 10023", rating: 8, user_id: tracetrace.id}
prop3 = {address: "1 Stuyvesant Oval, New York, NY 10009", rating: 7, user_id: hoahoa.id}
prop4 = {address: "515 W 52nd St, New York, NY 10019", rating: 10, user_id: tracetrace.id}
prop5 = {address: "11 E 1st St, New York, NY 10003", rating: 8, user_id: kevkev.id}
prop6 = {address: "105 W 29th St, New York, NY 10001", rating: 9, user_id: samsam.id}

prop_1 = FavoriteProperty.create(prop1)
prop_2 = FavoriteProperty.create(prop2)
prop_3 = FavoriteProperty.create(prop3)
prop_4 = FavoriteProperty.create(prop4)
prop_5 = FavoriteProperty.create(prop5)
prop_6 = FavoriteProperty.create(prop6)

#type is rating or distance
crit1 = {description: "museum", type: "distance", api_url: ""}
crit2 = {description: "subway", type: "distance", api_url: ""}
crit3 = {description: "park", type: "distance", api_url: ""}
crit4 = {description: "school", type: "rating", api_url: ""}
crit5 = {description: "price", type: "rating", api_url: ""}
crit6 = {description: "food", type: "distance", api_url: ""}

crit_1 = Criterium.create(crit1)
crit_2 = Criterium.create(crit2)
crit_3 = Criterium.create(crit3)
crit_4 = Criterium.create(crit4)
crit_5 = Criterium.create(crit5)
crit_6 = Criterium.create(crit6)

upref1 = {score: , user_id: , criterium_id: }
upref2 = {score: , user_id: , criterium_id: }
upref3 = {score: , user_id: , criterium_id: }
upref4 = {score: , user_id: , criterium_id: }
upref5 = {score: , user_id: , criterium_id: }
upref6 = {score: , user_id: , criterium_id: }

upref_1 = UserPreference.create(upref1)
upref_2 = UserPreference.create(upref2)
upref_3 = UserPreference.create(upref3)
upref_4 = UserPreference.create(upref4)
upref_5 = UserPreference.create(upref5)
upref_6 = UserPreference.create(upref6)





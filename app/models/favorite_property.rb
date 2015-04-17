class FavoriteProperty < ActiveRecord::Base
	belongs_to :user

	def distance_from_work(home_location, work_location)
		#This will carry miles distance between home and work
		distance = home_location - work_location
		return distance
	end
end

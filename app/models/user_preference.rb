class UserPreference < ActiveRecord::Base
	belongs_to :user
	belongs_to :criterium

  scope :get_user_pref, ->(user) { where(user: user) }
end

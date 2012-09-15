class Argument < ActiveRecord::Base

	#has_many :users
	has_many :posts
	has_many :userstatuses

end
class User < ActiveRecord::Base

	has_many :posts
	#has_many :arguments
	has_many :userstatuses

end
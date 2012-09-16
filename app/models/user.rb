class User < ActiveRecord::Base
	has_secure_password

	has_many :posts
	#has_many :arguments
	has_many :userstatuses

	def self.authenticate(email, password)
		find_by_email(email).try(:authenticate, password)
	end

	def desc_posts(argid)
		self.posts.where(:argument_id => argid).order("created_at desc")
	end
	
end
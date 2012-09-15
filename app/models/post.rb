class Post < ActiveRecord::Base

	belongs_to :user
	belongs_to :argument

	def user_name
		self.user.name
	end

end
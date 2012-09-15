class Argument < ActiveRecord::Base

	#has_many :users
	has_many :posts
	has_many :userstatuses

	def user1
		User.find(self.user_id1)
	end

	def user2
		User.find(self.user_id2)
	end

	def last_post(user)
		post = "No way!"
		if (user == 1)
			lastu1 = user1.posts.last
			post = lastu1.content unless lastu1.nil?
		else
			lastu2 = user2.posts.last
			post = lastu2.content unless lastu2.nil?
		end
		return post
	end

	def last_post_time(user)
		lastTime = 1.minute.ago
		if (user == 1)
			lastTime1 = user1.posts.last
			lastTime = lastTime1.created_at unless lastTime1.nil?
		else
			lastTime2 = user2.posts.last
			lastTime = lastTime2.created_at unless lastTime2.nil?
		end
		return lastTime
	end

	def contains(user)
		return ((user.id == self.user_id1) || (user.id == self.user_id2))
	end

end
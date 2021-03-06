require 'fastthread'

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

	def us1
		Userstatus.where(:argument_id => self.id, :user_id => self.user_id1).first
	end

	def us2
		Userstatus.where(:argument_id => self.id, :user_id => self.user_id2).first
	end

	def winnerName
		if (self.winner_id != 0  && !self.winner_id.nil?)
			user = User.find(self.winner_id)
			return user.name
		else
			return "Tie"
		end
	end

	def noWayPosts
		@p1 = Post.new()
		@p1.user_id = self.user_id1
		@p1.argument_id = self.id
		@p1.content = "No way!"
		@p1.save()

		@p2 = Post.new()
		@p2.user_id = self.user_id2
		@p2.argument_id = self.id
		@p2.content = "No way!"
		@p2.save()
	end

	def createUS
		us1 = Userstatus.new()
		us1.user_id = self.user_id1
		us1.argument_id = self.id
		us1.health = 100
		us1.save()

		us2 = Userstatus.new()
		us2.user_id = self.user_id2
		us2.argument_id = self.id
		us2.health = 100
		us2.save()
	end

	def startProcess
		argId = self.id
		t = Thread.new do
			if ENV['RAILS_ENV'] == 'development'
				ActiveRecord::Base.establish_connection(
				   :adapter => "sqlite3",
	  			   :database => "db/development.sqlite3"
	  			)
			else
				ActiveRecord::Base.establish_connection(
				  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
				  :host     => db.host,
				  :port     => db.port,
				  :username => db.user,
				  :password => db.password,
				  :database => db.path[1..-1],
				  :encoding => 'utf8'
				)
			end

			while (Argument.isRunning(argId)) do
				begin
					sleep 15
					Argument.update(argId)
					Argument.markVotes(argId)
					puts "Thread ran"
				rescue Exception => e
					Thread.main.raise e
					self.startProcess
				end
			end
		end
	end

	def self.isRunning(argnum)
		userStatuses = Userstatus.where(:argument_id => argnum).map(&:health)
		return !(userStatuses.map{|x| x <= 0}.include? true)
	end

	def self.update(argnum)
		argument = Argument.find(argnum)
		newVotes = argument.newVotes

		countForP1 = newVotes.find_all{|x| x.user_id == argument.user_id1}.count
		countForP2 = newVotes.find_all{|x| x.user_id == argument.user_id2}.count
		total = countForP1 + countForP2

		if (countForP1 > countForP2)
			puts "p1more"
			ratio = (((countForP1.to_f / total.to_f) - 0.5) * 100).to_i
			#min 15
			toAdd = [15,ratio].max
			#max 50
			toAdd = [50, toAdd].min
			#hit p2 with toAdd
			p2status = argument.us2
			currentHealth = p2status.health
			newHealth = [0,(currentHealth-toAdd)].max
			p2status.health = newHealth
			p2status.save()
		elsif (countForP2 > countForP1)
			puts "p2more"
			ratio = (((countForP2.to_f / total.to_f) - 0.5) * 100).to_i
			#min 15
			toAdd = [15,ratio].max
			#max 50
			toAdd = [50, toAdd].min
			#hit p1 with toAdd
			p1status = argument.us1
			currentHealth = p1status.health
			newHealth = [0,(currentHealth-toAdd)].max
			p1status.health = newHealth
			p1status.save()
		else
			puts "equal"
			p1status = argument.us1
			currentHealth = p1status.health
			newHealth = [0,(currentHealth-10)].max
			p1status.health = newHealth
			p1status.save()

			p2status = argument.us2
			currentHealth = p2status.health
			newHealth = [0,(currentHealth-10)].max
			p2status.health = newHealth
			p2status.save()
		end
	end

	def self.markVotes(argnum)
		argument = Argument.find(argnum)
		newVotes = argument.newVotes
		newVotes.each do |nv|
			nv.counted = true
			nv.save()
		end
	end

	def votesFor(user)
		if (user ==1 )
			postsIDs1 = self.posts.where(:user_id => self.user_id1).map(&:id)
	    	votecount1 = Vote.where(:post_id => postsIDs1).count
	    	return votecount1
	    else
	    	postsIDs2 = self.posts.where(:user_id => self.user_id2).map(&:id)
			votecount2 = Vote.where(:post_id => postsIDs2).count
			return votecount2
		end
	end

	def newVotes
		postIds = self.posts.map(&:id)
		allVotes = Vote.where(:post_id => postIds)
		newVotes = allVotes.find_all{ |x| x.counted == false }
		return newVotes
	end

	def last_post(user)
		post = "No way!"
		if (user == 1)
			lastu1 = user1.posts.where(:argument_id => self.id).last
			post = lastu1.content unless lastu1.nil?
		else
			lastu2 = user2.posts.where(:argument_id => self.id).last
			post = lastu2.content unless lastu2.nil?
		end
		return post
	end

	def last_post_full(user)
		if (user == 1)
			lastu1 = user1.posts.where(:argument_id => self.id).last
			return lastu1
		else
			lastu2 = user2.posts.where(:argument_id => self.id).last
			return lastu2
		end
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

	def json_posts(user)
		userposts = []
		if (user == 1)
			userposts = self.posts.where(:user_id => self.user_id1)
		else
			userposts = self.posts.where(:user_id => self.user_id2)
		end
		return mapPostsToJson(userposts)
	end

	def mapPostsToJson(posts)
		posts = posts.map{ |x| 
			{
				content: x.content,
				stamp: x.created_at
			}
		}
		return posts
	end

end
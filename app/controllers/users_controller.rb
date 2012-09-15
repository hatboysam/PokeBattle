class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def index
		@users = User.all
	end

	def search
		@users = User.all
		#@users = @users.map{ |x| 
			#{
			#	label: x.name,
			#	value: x.id
			#}
		#}
		@users = @users.map(&:name)
		
		respond_to do |format|
			format.json
			format.js do
				render "search.json"
			end
		end
	end

	def create
		@user = User.new(params[:user])
		if (@user.save)
			redirect_to @user
		else
			redirect_to "new"
		end
	end

	def show
		@user = User.find(params[:id])
	end

end
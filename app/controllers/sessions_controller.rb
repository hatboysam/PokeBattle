class SessionsController < ApplicationController
	include SessionsHelper

	def new
	end

	def create
		@user = User.find_by_email(params[:email])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			flash[:notice] = "Welcome back!"
			redirect_back_or arguments_path
		else
			flash[:notice] = "Bad login, try again"
			redirect_to signin_path
		end
	end

	def destroy
		session[:user_id] = nil
		sign_out
		flash[:notice] = "Logged out!"
		redirect_to root_url
	end

end
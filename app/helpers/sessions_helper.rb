module SessionsHelper
	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= user_from_remember_token
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
	end

	def authenticate
		deny_access unless signed_in?
	end

	def deny_access
		store_location
		flash[:notice] = "You must be signed in to do that"
		redirect_to signin_path
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end

private

	def user_from_remember_token
		if session[:user_id].nil?
			nil
		else
			User.find(session[:user_id])
		end
	end

	def store_location
		session[:return_to] = request.fullpath
	end

	def clear_return_to
		session[:return_to] = nil
	end
end
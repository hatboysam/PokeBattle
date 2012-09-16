class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  	@argument = Argument.last
  	@user1 = @argument.user1
  	@user2 = @argument.

  	@us1 = @argument.us1
  	@us2 = @argument.us2
  end

end

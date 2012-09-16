class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  	@argument = Argument.last
  	@user1 = @argument.user1
  	@user2 = @argument.user2

  	@us1 = @argument.us1
  	@us2 = @argument.us2

  	@votecount1 = @argument.votesFor(1)
    @votecount2 = @argument.votesFor(2)
  end

end

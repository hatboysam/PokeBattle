class PostsController < ApplicationController

def create
    @argument = Argument.find(params[:argument_id])
    @post = @argument.posts.create(params[:post])
    redirect_to argument_path(@argument)
end

def destroy

end

end

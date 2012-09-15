class PostsController < ApplicationController

def create
    @post = Post.new(params[:post])
    @post.save
    redirect_to @post.argument
end

def destroy

end

end

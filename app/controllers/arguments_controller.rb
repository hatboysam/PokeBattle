class ArgumentsController < ApplicationController
  include SessionsHelper

  before_filter :authenticate, :only => [:new, :create]

  def index
    @arguments = Argument.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @arguments }
    end
  end

  def show
    @argument = Argument.find(params[:id])
    @user1 = User.find(@argument.user_id1)
    @user2 = User.find(@argument.user_id2)

    @us1 = @argument.us1
    @us2 = @argument.us2

    @post = Post.new
  end

  def new
    @argument = Argument.new
    @users = User.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def vote
    body = params[:Body]
    textcode = body.split(" ").first
    voting = body.split(" ").last

    @vote = Vote.new
    @vote.from = params[:From]
    @argument = Argument.find_by_textcode(textcode)
    if (voting == "1")
      @user = User.find(@argument.user_id1)
      @vote.post_id = @user.posts.last.id
      @vote.user_id = @user.id
    elsif(voting == "2")
      @user = User.find(@argument.user_id2)
      @vote.post_id = @user.posts.last.id 
      @vote.user_id = @user.id
    end
  end

  def edit

  end

  def create
    user_id2 = params[:argument][:user_id2]
    @against = User.find(user_id2)
    params[:argument][:user_id2] = @against.id

    @argument = Argument.new(params[:argument])
    @argument.textcode = rand(8999) + 1000
    @argument.user_id1 = current_user.id
    if @argument.save()
      redirect_to argument_path(@argument)
    else
      redirect_to "/arguments/new"
    end
  end

  def posts
    @argument = Argument.find(params[:id])
    @user1 = @argument.user1
    @user2 = @argument.user2
    @u1posts = @argument.json_posts(1)
    @u2posts = @argument.json_posts(2)

    respond_to do |format|
      format.json
      format.html { render :layout => false }
    end
    
  end

  def firstposts
    @argument = Argument.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end

  def healthstatus
    @argument = Argument.find(params[:id])
    @us1 = @argument.us1
    @us2 = @argument.us2
  end

  def start
    @argument = Argument.find(params[:id])
    @argument.started = true
    @argument.save()
    @argument.startProcess
  end

  def update

  end

  def destroy

  end
  

end

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
    @post = Post.new
  end

  def new
    @argument = Argument.new
    @users = User.all
    respond_to do |format|
      format.html #new.html.erb
      format.json { render :json => @argument }
    end
  end

  def vote
    body = params[:Body]
    #arr = body.split(" +")
    textcode = body.split(" ").first
    voting = body.split(" ").last

    @vote = Vote.new
    @vote.from = params[:From]
    @argument = Argument.find_by_textcode(textcode)
    if (voting == "1")
	@user = User.find(@argument.user_id1)
	@vote.post_id = @user.posts.last.id
    elsif(voting == "2")
	@user = User.find(@argument.user_id2)
	@vote.post_id = @user.posts.last.id 
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

    respond_to do |format|
      if @argument.save
        format.html { redirect_to @argument, :notice => 'Post was successfully created.' }
        format.json { render :json => @argument, :status => :created, :location => @argument }
      else
        format.html { render :action => "new" }
        format.json { render :json => @argument.errors, :status => :unprocessable_entity }
      end
    end
  end



  def update

  end

  def destroy

  end
  

end

class ArgumentsController < ApplicationController

  def index
    @arguments = Argument.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @arguments }
    end
  end

  def show
    @argument = Argument.find(params[:id])
  end

  def new
    @argument = Argument.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @argument }
    end

  end

  def edit

  end

  def create
    @argument = Argument.new(params[:argument])
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
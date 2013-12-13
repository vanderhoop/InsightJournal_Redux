class EntriesController < ApplicationController

  def index
    @entries = Entry.all
  end

  def show
    # @entry = Entry.find(params[])
  end

  def create
    binding.pry
    @entry = Entry.new(params[:entry])
    if @entry.save
      redirect_to @entry
    else

    end
  end

  def new
    @entry = Entry.new
  end

  def edit
  end


  def update
  end

  def destroy

  end
end

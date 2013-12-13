class EntriesController < ApplicationController

  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def create
    @entry = Entry.new(params[:entry])
    @entry.user_id = current_user.id
    if @entry.save
      # because entries are a nested resource, need to pass the
      # parent resource, otherwise you will get 'undefined method entry_url
      redirect_to [@user, @entry]
    else

    end
  end

  def new
    # @entry = Entry.new
  end

  def edit
  end


  def update
  end

  def destroy

  end
end

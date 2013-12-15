require 'alchemy'

class EntriesController < ApplicationController

  def index
    @entries = current_user.entries
    # TODO add link to user dashboard that takes users to a view of all of their entries.
  end

  def show
    @entry = Entry.find(params[:id])
    @day_created = @entry.created_at.strftime("%B %d, %Y")
    # binding.pry
    @url = "users/#{params[:user_id]}/entries/#{params[:id]}"

  end

  def create
    # on instantiation of new Entry, a combined entity+relations call will be made to the API
    @entry = Entry.new(params[:entry])
    @entry.user_id = current_user.id
    @entry.word_count = params[:entry][:text].split(' ').length
    if @entry.save
      @entry.create_entities(@entry.instance_entities)
      flash[:notice] = "Entry successfully created."
      # nested resources are passed as an array on redirect,
      # otherwise you will get 'undefined method entry_url'
      redirect_to [@user, @entry]
    else
      flash[:notice] = "Your entry was only #{@entry.word_count} word(s) long. Viable entries must be at least ____ words/characters."
      render :action => :new
    end
  end

  def new
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(params[:entry])
      # TODO are word counts updated? I'm too tired to figure out where to persist this data
      @entry.word_count = @entry.text.split(' ').length
      flash[:notice] = "Entry successfully updated!"
      redirect_to [@user, @entry]
    else
      flash[:error] = "Entry couldn't be updated"
      render :action => :edit
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    if @entry.destroy
      flash[:notice] = "Your entry was successfully erased!"
      redirect_to "/"
    else
      flash[:error] = "Couldn't destroy your entry. It's protected by the many pecking hens of Endor."
      render :action => :show
    end
  end
end

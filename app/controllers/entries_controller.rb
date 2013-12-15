require 'alchemy'

class EntriesController < ApplicationController

  def index
    @entries = Entry.all
    # TODO add link to user dashboard that takes users to a view of all of their entries.
  end

  def show
    @entry = Entry.find(params[:id])
    @day_created = @entry.created_at.strftime("%B %d, %Y")
    # binding.pry
    @url = "users/#{params[:user_id]}/entries/#{params[:id]}"

  end

  def create
    alchemy_api = Alchemy.new()
    @entry = Entry.new(params[:entry])
    @entry_entities = alchemy_api.entities('text', @entry.text, { sentiment: 1 })["entities"]
    @entry.user_id = current_user.id
    @entry.word_count = params[:entry][:text].split(' ').length

    if @entry.save
      @entry.create_entities(@entry_entities)

      # because entries are a nested resource, need to pass the
      # parent resource on redirect, otherwise you will get 'undefined method entry_url'
      flash[:notice] = "Entry successfully created."
      redirect_to [@user, @entry]
    else
      flash[:notice] = "Your entry was only #{@entry.word_count} word(s) long. Viable entries must be at least ____ words/characters."
      render :action => :new
    end
  end

  def new
    @entry = Entry.new
  end

  def edit
    @entry = Entry.find(params[:id])

  end

  def update
    alchemy_api = Alchemy.new()
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(params[:entry])
      # destroy all entities associated with entry,
      # as entities may be entirely differnent in the updated text
      @entry.entities.each do |entity|
        entity.destroy
      end
      # make new call to API with updated text, returns array of entities
      @entry_entities = alchemy_api.entities('text', @entry.text, { sentiment: 1 })["entities"]
      # TODO are word counts updated? I'm too tired to figure out where to persist this data
      @entry.word_count = @entry.text.split(' ').length

      # create new entities that point to the updated entry.
      @entry.create_entities(@entry_entities)



      flash[:notice] = "Entry successfully updated!"
      redirect_to [@user, @entry]
    else
      flash[:error] = "Entry couldn't be updated"
      render :action => :edit
    end
    # binding.pry
  end

  def destroy
    # binding.pry
    @entry = Entry.find(params[:id])
    if @entry.destroy
      flash[:notice] = "Your entry was successfully erased!"
      redirect_to "/"
    else
      flash[:error] = "Couldn't destroy your entry. It's protected by the many pecking hens of Endor"
      render :action => :show
    end
  end
end

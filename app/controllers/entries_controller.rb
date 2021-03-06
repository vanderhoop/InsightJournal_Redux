class EntriesController < ApplicationController
  before_filter :user_signed_in?

  # I include EntryUtils because the Entries controller relies on the
  # get_relations method, which previously lived in the application controller
  include EntryUtils

  def index
    @entries = current_user.entries
  end

  def show
    @entry = Entry.find(params[:id])
    @day_created = @entry.created_at.strftime("%B %d, %Y")
  end

  def create
    @entry = Entry.new(params[:entry])
    @entry.word_count = params[:entry][:text].split(' ').length
    @entry.user_id = params["user_id"].to_i
    @entry.set_hour_created
    # before @entry.save is called, both an 'entity' and a 'relations' call
    # are made to the API. Both set instance variables of the Entry
    if @entry.save
      @entry.create_entities(@entry.instance_entities)
      flash[:notice] = "Entry successfully created."
      redirect_to "/users/#{@entry.user_id}/insights"
      # TODO Once I've setup entry-specific insights to the entries#show page, change redirect back to the entry itself
      # redirect_to [@user, @entry]
    else
      flash[:error] = @entry.errors.full_messages.to_sentence
      render :action => :new
    end

  end # create

  def new
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    entry_hash = params[:entry]
    # TODO refactor the setting of word_count and tense_orientation
    # resets word_count and tense orientation
    entry_hash["word_count"] = entry_hash["text"].split(' ').length
    entry_hash["tense_orientation"] = get_relations(entry_hash["text"])
    if @entry.update_attributes(entry_hash)
      flash[:notice] = "Entry successfully updated!"
      redirect_to [@user, @entry]
    else
      flash[:error] = @entry.errors.full_messages.to_sentence
      render :action => :edit
    end
  end #update

  def destroy
    @entry = Entry.find(params[:id])
    if @entry.destroy
      flash[:notice] = "Your entry was erased."
      redirect_to "/"
    else
      flash[:error] = "Couldn't destroy your entry. It's protected by the many pecking hens of Endor."
      render :action => :show
    end
  end # destroy
end # EntriesController

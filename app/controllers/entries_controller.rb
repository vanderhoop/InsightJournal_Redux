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
    binding.pry
    @entry = Entry.new(params[:entry])
    @entry.user_id = current_user.id
    @entry.word_count = params[:entry][:text].split(' ').length


    if @entry.save
      # because entries are a nested resource, need to pass the
      # parent resource on redirect, otherwise you will get 'undefined method entry_url'
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
    @entry = Entry.find(params[:id])
    @entry.word_count = @entry.text.split(' ').length
    # binding.pry
    if @entry.update_attributes(params[:entry])
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

class EntriesController < ApplicationController
  before_action :set_place
  before_action :set_entry, only: [:show]
  before_action :require_login

  def index
    @entries = @place.entries.where(user_id: session[:user_id])  # ✅ Only show user's entries
  end

  def show
    unless @entry.user_id == session[:user_id]
      redirect_to place_entries_path(@place), alert: "You do not have access to this entry."
    end
  end

  def new
    @entry = @place.entries.new
  end

  def create
    @entry = @place.entries.new(entry_params)
    @entry.user_id = session[:user_id]  # ✅ Assign current user

    if @entry.save
      redirect_to place_entries_path(@place), notice: "Entry added successfully!"
    else
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def set_entry
    @entry = @place.entries.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image)
  end

  def require_login
    redirect_to login_path, alert: "You must be logged in to access this page." unless session[:user_id]
  end
end

class EntriesController < ApplicationController
  before_action :require_login
  before_action :set_place
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]

  def index
    @entries = @place.entries.where(user: current_user).order(occurred_on: :desc)
  end

  def new
    @entry = @place.entries.build
  end

  def create
    @entry = @place.entries.build(entry_params)
    @entry.user = current_user  # ✅ Assign current user

    if @entry.save
      redirect_to place_path(@place), notice: "Entry added successfully!"
    else
      render :new
    end
  end

  private

  def set_place
    @place = current_user.places.find_by(id: params[:place_id])  # ✅ Restrict access
    redirect_to places_path, alert: "Place not found or unauthorized." unless @place
  end

  def set_entry
    @entry = @place.entries.find_by(id: params[:id])
    redirect_to place_path(@place), alert: "Entry not found or unauthorized." unless @entry
  end

  def authorize_user!
    redirect_to place_path(@place), alert: "Not authorized to view this entry!" unless @entry.user == current_user
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image)
  end
end

class PlacesController < ApplicationController
  before_action :require_login  # Ensures users are logged in
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = current_user.places.order(created_at: :desc)  # ✅ Only show places belonging to the logged-in user
  end

  def show
    @entries = @place.entries.where(user: current_user).order(occurred_on: :desc)
  end

  def new
    @place = current_user.places.build  # ✅ Associate new places with the current user
  end

  def create
    @place = current_user.places.build(place_params)
    if @place.save
      redirect_to new_place_entry_path(@place), notice: "Place created! Now add your first entry."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      redirect_to @place, notice: "Place updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @place.destroy
    redirect_to places_path, notice: "Place deleted successfully!"
  end

  private

  def set_place
    @place = current_user.places.find_by(id: params[:id])  # ✅ Restrict access to user's places
    redirect_to places_path, alert: "Place not found or unauthorized." unless @place
  end

  def place_params
    params.require(:place).permit(:name)
  end
end

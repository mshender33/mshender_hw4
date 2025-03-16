class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all
  end

  def show
    @entries = @place.entries.includes(:user).order(occurred_on: :desc)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user  # Ensure the place is assigned to the logged-in user

    if @place.save
      # Redirect to creating an entry for this newly created place
      redirect_to new_place_entry_path(@place), notice: "Place created! Now add an entry."
    else
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name)
  end
end

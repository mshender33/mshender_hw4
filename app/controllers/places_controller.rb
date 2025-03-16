class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])  # ✅ Corrected: No need to use find_by
    @entries = @place.entries  # ✅ Simplified: Use ActiveRecord association
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)  # ✅ Use strong params for security
    if @place.save
      redirect_to places_path, notice: "Place created successfully!"
    else
      render :new  # ✅ Stay on form if validation fails
    end
  end

  private

  def place_params
    params.require(:place).permit(:name)  # ✅ Strong params
  end
end

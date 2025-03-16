class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :require_login  # Ensure user is logged in

  def index
    @places = Place.where(user_id: session[:user_id])  # ✅ Only show user's places
  end

  def show
    if @place.user_id != session[:user_id]
      redirect_to places_path, alert: "You do not have access to this place."
    else
      @entries = @place.entries.order(occurred_on: :desc)
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = session[:user_id]  # ✅ Assign current user

    if @place.save
      redirect_to places_path, notice: "Place created successfully!"
    else
      render :new
    end
  end

  def destroy
    if @place.user_id == session[:user_id]
      @place.destroy
      redirect_to places_path, notice: "Place deleted successfully!"
    else
      redirect_to places_path, alert: "You are not authorized to delete this place."
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name)
  end

  def require_login
    redirect_to login_path, alert: "You must be logged in to access this page." unless session[:user_id]
  end
end

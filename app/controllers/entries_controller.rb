class EntriesController < ApplicationController
  before_action :set_place
  before_action :set_entry, only: [:show]

  def index
    @entries = @place.entries
  end

  def show
  end

  def new
    @entry = @place.entries.new
  end

  def create
    @entry = @place.entries.new(entry_params)
    if @entry.save
      redirect_to place_entries_path(@place), notice: "Entry created successfully!"
    else
      flash.now[:alert] = "There was an error creating the entry."
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])  # ✅ Ensures entries are scoped under places
  end

  def set_entry
    @entry = @place.entries.find(params[:id])  # ✅ Avoids unnecessary queries
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :date, :image)  # ✅ Strong params
  end
end

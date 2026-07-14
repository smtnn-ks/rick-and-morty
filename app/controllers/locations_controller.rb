class LocationsController < ApplicationController
  ITEMS_PER_PAGE = 20

  def index
    @page = params[:page]&.to_i || 1
    page_offset = (@page - 1) * ITEMS_PER_PAGE
    @locations = Location.all.offset(page_offset).limit(ITEMS_PER_PAGE)
    @is_last_page = page_offset + ITEMS_PER_PAGE >= Location.count
    redirect_to locations_path, alert: "Invalid page" if @locations.empty?
  end

  def show
    @location = Location.find(params[:id])
  end
end

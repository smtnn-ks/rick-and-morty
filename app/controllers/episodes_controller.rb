class EpisodesController < ApplicationController
  ITEMS_PER_PAGE = 20

  def index
    @page = params[:page]&.to_i || 1
    page_offset = (@page - 1) * ITEMS_PER_PAGE
    @episodes = Episode.all.offset(page_offset).limit(ITEMS_PER_PAGE)
    @is_last_page = page_offset + ITEMS_PER_PAGE >= Episode.count
    redirect_to episodes_path, alert: "Invalid page" if @episodes.empty?
  end

  def show
    @episode = Episode.find(params[:id])
  end
end

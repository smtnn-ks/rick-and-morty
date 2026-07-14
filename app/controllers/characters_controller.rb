class CharactersController < ApplicationController
  ITEMS_PER_PAGE = 20

  def index
    @page = params[:page]&.to_i || 1
    page_offset = (@page - 1) * ITEMS_PER_PAGE
    @characters = Character.all.offset(page_offset).limit(ITEMS_PER_PAGE)
    @is_last_page = page_offset + ITEMS_PER_PAGE >= Character.count
    redirect_to characters_path, alert: "Invalid page" if @characters.empty?
  end

  def show
    @character = Character.find(params[:id])
  end
end

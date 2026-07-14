class SyncCharactersJob < ApplicationJob
  queue_as :default

  def initialize(character_service: RickAndMortyApi::CharacterService.new)
    @character_service = character_service
  end

  def perform
    page = 1
    loop do
      records, is_last_page = @character_service.get page
      records.each { |record| Character.create!(record) }
      break if is_last_page
      page += 1
    end
  end
end

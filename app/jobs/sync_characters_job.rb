class SyncCharactersJob < ApplicationJob
  queue_as :default

  def initialize(character_service: RickAndMortyApi::CharacterService.new)
    @character_service = character_service
  end

  def perform
    page = 1
    loop do
      records, is_last_page = @character_service.get page

      records.each do |record|
        candidate = Character.find_by("id = ?", record[:id])
        if candidate
          candidate.update! record
        else
          Character.create! record
        end
      end

      break if is_last_page
      page += 1
    end
  end
end

class SyncCharactersJob < ApplicationJob
  queue_as :default

  def initialize(
    character_service: RickAndMortyApi::CharacterService.new,
    character_avatar_service: RickAndMortyApi::CharacterAvatarService.new
  )
    @character_service = character_service
    @character_avatar_service = character_avatar_service
  end

  def perform
    page = 1
    loop do
      records, is_last_page = @character_service.get page

      records.each do |record|
        candidate = Character.find_by("id = ?", record[:id])

        if candidate
          candidate.update! record.except(:image_url)
        else
          candidate = Character.create! record.except(:image_url)
        end

        image = @character_avatar_service.get(record[:id])
        candidate.image.attach(
          io: StringIO.new(image),
          filename: "character-#{record[:id]}.jpeg"
        )
      end

      break if is_last_page
      page += 1
    end
  end
end

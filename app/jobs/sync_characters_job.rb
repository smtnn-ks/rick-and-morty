class SyncCharactersJob < ApplicationJob
  queue_as :default

  def initialize(
    character_service: RickAndMortyApi::CharacterService.new,
    image_service: RickAndMortyApi::ImageService.new
  )
    @character_service = character_service
    @image_service = image_service
  end

  def perform
    page = 1
    loop do
      records, is_last_page = @character_service.get page

      records.each do |record|
        image = @image_service.get(record[:image_url])
        record.delete(:image_url)

        candidate = Character.find_by("id = ?", record[:id])
        if candidate
          candidate.update! record
        else
          candidate = Character.create! record
        end

        candidate.image.attach(io: StringIO.open(image), filename: "characters/#{record[:id]}.jpeg")
      end

      break if is_last_page
      page += 1
    end
  end
end

class SyncEpisodesJob < ApplicationJob
  queue_as :default

  def initialize(episode_service: RickAndMortyApi::EpisodeService.new)
    @episode_service = episode_service
  end

  def perform
    page = 1
    loop do
      records, is_last_page = @episode_service.get page
      Episode.upsert_all records
      break if is_last_page
      page += 1
    end
  end
end

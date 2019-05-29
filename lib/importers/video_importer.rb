# frozen_string_literal: true

# Using a client and a gateway, it imports external music videos into the local database.
class VideoImporter
  def initialize(client: SofarAmazonClient, gateway: SofarVideoGateway)
    @client = client
    @gateway = gateway
  end

  def import(clean_slate = true)
    Video.destroy_all if clean_slate
    videos_response = @client.music_videos
    videos_response.each(&method(:process_entry))
  end

  private

  def process_entry(entry)
    video = @gateway.new(entry)
    Video.create(
      video_uid: video.video_uid,
      song_name: video.song_name,
      artist_name: video.artist_name,
      city: video.city,
      data: entry
    )
  end
end

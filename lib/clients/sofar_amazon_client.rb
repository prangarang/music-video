# frozen_string_literal: true

# Client for connecting to Sofar Sounds AWS
class SofarAmazonClient
  include HTTParty

  base_uri 'https://s3-eu-west-1.amazonaws.com'

  def self.music_videos
    response = get('/sofar-eu-1/video_data.json')
    return JSON.parse(response.body) if response.code == 200

    raise StandardError, "Code: #{response.code}, response: #{response.body}"
  end
end

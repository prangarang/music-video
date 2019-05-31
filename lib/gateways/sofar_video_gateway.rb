# frozen_string_literal: true

# Used to interact with individual video entry from Sofar Sounds json file hosted on Amazon
class SofarVideoGateway
  attr_accessor :video

  SONG_ATTRS = [:song].freeze
  SONG_NAME = (SONG_ATTRS + [:title]).freeze
  CITY = (SONG_ATTRS + %i[city title]).freeze
  ARTIST_NAME = (SONG_ATTRS + %i[artist title]).freeze

  def initialize(video)
    @video = video.with_indifferent_access
  end

  def video_uid
    @video[:video_uid]
  end

  def song_name
    @video.dig(*SONG_NAME)
  end

  def artist_name
    @video.dig(*ARTIST_NAME)
  end

  def city
    @video.dig(*CITY)
  end
end

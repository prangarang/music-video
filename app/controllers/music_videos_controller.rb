# frozen_string_literal: true

# Controller for MusicVideos resource
class MusicVideosController < ApplicationController
  def index
    videos = Video.search(music_video_search_params)
    json_response(videos.map(&:data))
  end

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def music_video_search_params
    params.permit(:song_name, :artist_name, :city)
  end
end

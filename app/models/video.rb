# frozen_string_literal: true

class Video < ApplicationRecord
  scope :song_name, ->(name) { where 'MATCH (song_name) AGAINST (?)', name }
  scope :city, ->(city) { where 'MATCH (city) AGAINST (?)', city }
  scope :artist_name, ->(name) { where 'MATCH (artist_name) AGAINST (?)', name }

  def self.search(params)
    videos = Video.where(nil)
    videos = videos.song_name(params[:song_name]) if params[:song_name].present?
    videos = videos.city(params[:city]) if params[:city].present?
    videos = videos.artist_name(params[:artist_name]) if params[:artist_name].present?
    videos
  end
end

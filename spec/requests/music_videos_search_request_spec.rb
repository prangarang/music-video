# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicVideosController, type: :request do
  describe '#index' do
    include_context 'videos created and indexed'

    it 'successfully returns the matching record' do
      get '/music_videos?song_name=matchstick'
      expect(response).to be_success
      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
      expect(json.first).to eq(@matchstick_men.data)
    end
  end
end

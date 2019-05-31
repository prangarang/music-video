# frozen_string_literal: true

require 'rails_helper'
# Pre-loaded but keeping for documentation purposes
require Rails.root.join('spec/support/shared_examples.rb')

RSpec.describe Video, type: :model do
  describe '.search' do
    include_context 'videos created and indexed'

    shared_examples_for 'supports full text search' do |search_parameters|
      it 'returns the correct video' do
        result = described_class.search(search_parameters)
        expect(result).to eq [@yoshimi_battles]
      end
    end

    context 'when search terms match one record' do
      it_behaves_like 'supports full text search', song_name: 'battles the pink'
      it_behaves_like 'supports full text search', city: 'london'
      it_behaves_like 'supports full text search',
                      artist_name: 'flaming', song_name: 'pink robots'
    end

    context 'when searching matches multiple videos' do
      it 'returns all matching videos' do
        result = described_class.search(song_name: 'robots matchstick')
        expect(result).to contain_exactly(@matchstick_men, @yoshimi_battles)
      end
    end

    context 'when searching for videos that do not exist' do
      it 'returns an empty result' do
        result = described_class.search(song_name: 'heello')
        expect(result).to be_empty
      end
    end
  end
end

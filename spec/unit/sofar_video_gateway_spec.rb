# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('lib/gateways/sofar_video_gateway.rb')

RSpec.describe SofarVideoGateway do
  let(:entry) do
    {
      'song' =>
        {
          'city' => { 'title' => 'Edinburgh' },
          'title' => 'Matchstick Men',
          'artist' => { 'title' => 'Harry & the Hendersons' }
        },
      'video_uid' => '1K1TlA1gxqg'
    }
  end
  let(:gateway) { described_class.new(entry) }

  it { expect(gateway.video_uid).to eql('1K1TlA1gxqg') }
  it { expect(gateway.song_name).to eql('Matchstick Men') }
  it { expect(gateway.artist_name).to eql('Harry & the Hendersons') }
  it { expect(gateway.city).to eql('Edinburgh') }

  context 'when the entry is missing song information' do
    let(:entry) { { 'video_uid' => '1K1TlA1gxqg' } }

    it 'retuns nil and does not blow up when fetching information' do
      expect(gateway.video_uid).to eql('1K1TlA1gxqg')
      expect(gateway.song_name).to be_nil
      expect(gateway.artist_name).to be_nil
      expect(gateway.city).to be_nil
    end
  end
end

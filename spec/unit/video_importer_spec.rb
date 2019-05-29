require 'rails_helper'
require Rails.root.join('lib/importers/video_importer.rb')

RSpec.describe VideoImporter do
  let(:music_videos) do
    [
      FactoryBot.build(:video, :missing_artist_and_city).data,
      FactoryBot.build(:video, :matchstick_men).data,
      FactoryBot.build(:video, :missing_metadata).data
    ]
  end
  let(:service) { class_double(SofarAmazonClient, music_videos: music_videos) }

  subject { described_class.new(client: service).import }

  it 'loads' do
    expect { subject }.to change { Video.all.count }.from(0).to(3)

    videos = Video.all
    expect(videos.map(&:video_uid)).to contain_exactly(
      *music_videos.map { |v| v['video_uid'] }
    )
    expect(videos.map(&:song_name)).to contain_exactly(
      'Ballade', nil, 'Matchstick Men'
    )
    expect(videos.map(&:artist_name)).to contain_exactly(
      nil, nil, 'Harry & the Hendersons'
    )
    expect(videos.map(&:city)).to contain_exactly(
      nil, nil, 'Edinburgh'
    )
  end
end
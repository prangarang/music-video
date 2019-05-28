# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'
require Rails.root.join('lib/clients/sofar_amazon_client.rb')

RSpec.describe SofarAmazonClient do
  describe '.music_videos' do
    subject { described_class.music_videos }

    context 'when successful response status' do
      before do
        stub_request(:get, 'https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json')
            .to_return(status: 200, body: "[{\"video_uid\": \"wWRIyRRyTCI\"}]")
      end

      it 'returns the parsed json' do
        expect(subject.first['video_uid']).to eq('wWRIyRRyTCI')
      end
    end

    context 'when unsuccessful response status' do
      before do
        stub_request(:get, 'https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json')
            .to_return(status: 404, body: 'Not Found')
      end

      it 'raises an error with response information' do
        expect { subject }.to raise_error(StandardError)
                                  .with_message('Code: 404, response: Not Found')
      end
    end
  end
end

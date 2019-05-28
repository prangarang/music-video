# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    video_uid { (0...8).map { rand(65..90).chr }.join }

    trait :matchstick_men do
      video_uid { '1K1TlA1gxqg' }
      song_name { 'Matchstick Men' }
      artist_name { 'Harry & the Hendersons' }
      city { 'Edinburgh' }
      data do
        {
          'video_uid' => '1K1TlA1gxqg',
          'song' => {
            'id' => 6441,
            'artist_id' => 4934,
            'title' => 'Matchstick Men',
            'cached_slug' => 'matchstick-men',
            'city_id' => 45,
            'artist' => {
              'id' => 4934,
              'title' => 'Harry & the Hendersons',
              'cached_slug' => 'harry-the-hendersons'
            },
            'city' => {
              'id' => 45,
              'title' => 'Edinburgh',
              'cached_slue' => 'edinburgh'
            }
          }
        }
      end
    end

    trait :yoshimi_battles do
      video_uid { '6byyTidXKBE' }
      song_name { 'Yoshimi Battles The Pink Robots Part 1' }
      artist_name { 'The Flaming lips' }
      city { 'london' }
      data do
        { 'song' =>
          { 'id' => 4523,
            'city' => {
              'id' => 38,
              'title' => 'Barcelona',
              'cached_slug' => 'barcelona'
            },
            'title' => 'Live Your Life Alone',
            'artist' => {
               'id' => 3141,
               'title' => 'Wednesday Lips',
               'cached_slug' => 'wednesday-lips'
             },
            'city_id' => 38,
            'artist_id' => 3141,
            'cached_slug' => 'live-your-life-alone' },
          'video_uid' => '6byyTidXKBE' }
      end
    end

    trait :missing_artist_and_city do
      video_uid { '_3AoSE9lOhE' }
      song_name { 'Ballade' }
      data do
        {
          'video_uid' => '_3AoSE9lOhE',
          'song' => {
            'id' => 6402,
            'artist_id' => nil,
            'title' => 'Ballade',
            'cached_slug' => 'ballade--1',
            'city_id' => nil
          }
        }
      end
    end

    trait :missing_metadata do
      video_uid { 'ST29AI1PYVc' }
      data { { 'video_uid' => 'ST29AI1PYVc' } }
    end
  end
end

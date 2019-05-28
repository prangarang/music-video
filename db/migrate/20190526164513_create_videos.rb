class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :video_uid
      t.string :song_name
      t.string :artist_name
      t.string :city
      t.json :data

      t.timestamps

      t.index [:song_name], type: :fulltext
      t.index [:artist_name], type: :fulltext
      t.index [:city], type: :fulltext
    end
  end
end

class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :artist
      t.string :link_video

      t.timestamps
    end
  end
end

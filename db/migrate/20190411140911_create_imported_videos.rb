class CreateImportedVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :imported_videos do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :imported_from_id

      t.timestamps
    end
  end
end

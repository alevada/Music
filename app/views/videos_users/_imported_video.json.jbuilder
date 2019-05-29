json.extract! imported_video, :id, :user_id, :video_id, :imported_from_id, :created_at, :updated_at
json.url videos_user_url(imported_video, format: :json)

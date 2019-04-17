json.extract! video, :id, :name, :artist, :link_video, :created_at, :updated_at
json.url video_url(video, format: :json)

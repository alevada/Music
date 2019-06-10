json.extract! usr, :id, :username, :role_id, :is_public, :created_at, :updated_at
json.url usr_url(usr, format: :json)

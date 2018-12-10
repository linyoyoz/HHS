json.extract! user, :id, :name, :passwd, :permission, :created_at, :updated_at
json.url user_url(user, format: :json)

json.extract! thing, :id, :image, :description, :owner, :email, :created_at, :updated_at
json.url thing_url(thing, format: :json)

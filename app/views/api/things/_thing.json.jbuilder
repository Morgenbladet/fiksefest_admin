json.extract! thing, :id, :description, :owner, :created_at, :updated_at
json.image do
  json.large  thing.image.url(:large)
  json.square thing.image.url(:small)
  json.thumb  thing.image.url(:tiny)
end
json.url api_thing_url(thing, format: :json)

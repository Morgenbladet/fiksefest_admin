class Api::ThingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :owner,
    :created_at
  attribute :image do
    {
      large:  object.image.url(:large),
      square: object.image.url(:small),
      thumb:  object.image.url(:tiny)
    }
  end
end

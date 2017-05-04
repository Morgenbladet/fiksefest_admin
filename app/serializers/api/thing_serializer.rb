class Api::ThingSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper

  attributes :id, :title, :owner, :created_at
  
  attribute :description do
    simple_format(object.description)
  end

  attribute :image_links do
    {
      large:  object.image.url(:large),
      square: object.image.url(:small),
      thumb:  object.image.url(:tiny)
    }
  end

  has_many :comments do
    object.comments.published
  end
end

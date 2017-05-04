class Api::CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper
  belongs_to :thing

  attributes :id, :name, :text, :created_at

  def text
    simple_format(object.text)
  end
end

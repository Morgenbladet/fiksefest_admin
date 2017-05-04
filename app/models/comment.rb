class Comment < ApplicationRecord
  belongs_to :thing

  validates :text, :name, :email, presence: true

  scope :published, -> { where(published: true) }
end

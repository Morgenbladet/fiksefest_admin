class Comment < ApplicationRecord
  belongs_to :thing
  after_create :email_owner

  validates :text, :name, :email, presence: true

  scope :published, -> { where(published: true) }

  private

  def email_owner
    ThingsMailer.new_comment(self).deliver_later
  end
end

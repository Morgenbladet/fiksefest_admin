class Thing < ApplicationRecord
  after_update :send_email, if: :just_accepted?

  has_attached_file :image,
    styles: {
      tiny: "64x64#",
      small: "400x400#",
      large: "1024x1024>"
    },
    convert_options: {
      tiny: '-strip',
      small: '-strip',
      large: '-strip'
    },
    s3_protocol: :https

  validates_attachment :image,
    presence: true,
    content_type: { content_type: %w(image/jpeg image/gif image/png) },
    size: { in: 0..10.megabytes }

  process_in_background :image,
    processing_image_url: 'https://s3.eu-central-1.amazonaws.com/fiksefest/processing.png'

  validates :title, presence: true

  enum status: [ :in_queue, :accepted, :denied ]

  scope :published, -> { where(status: 'accepted') }

  has_many :comments, -> { order(created_at: :asc) }
  has_many :published_comments,
    -> { order(created_at: :asc).where(published: true) },
    class_name: 'Comment'

  private

  def just_accepted?
    status_changed? && accepted?
  end

  def send_email
    ThingsMailer.accepted(self).deliver_now
  end
end

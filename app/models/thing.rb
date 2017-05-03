class Thing < ApplicationRecord
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
    }

  validates_attachment :image,
    presence: true,
    content_type: { content_type: %w(image/jpeg image/gif image/png) },
    size: { in: 0..10.megabytes }

  process_in_background :image,
    processing_image_url: 'https://s3.eu-central-1.amazonaws.com/fiksefest/processing.png'

  validates :title, presence: true

  enum status: [ :in_queue, :accepted, :denied ]

  scope :published, -> { where(status: 'accepted') }
end

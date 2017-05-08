class Thing < ApplicationRecord
  include ActionView::Helpers::TextHelper
  after_update :send_email, if: :just_accepted?
  after_create :notify_slack

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

  def frontend_url
    "https://morgenbladet.no/fiksefest#/thing/%s" % self.id
  end

  def as_slack_attachment
    {
      fallback: "Ting #{self.title}: #{self.frontend_url}",
      title: "Ting: <#{self.frontend_url}|#{self.title}>",
      thumb_url: self.image.url(:tiny),
      fields: [
        { title: 'Historie', value: truncate(self.description, length: 100)},
        { title: 'Innsender', value: self.owner, short: true},
        { title: 'E-post',   value: self.email, short: true}
      ]
    }
  end

  private

  def just_accepted?
    status_changed? && accepted?
  end

  def send_email
    ThingsMailer.accepted(self).deliver_later
  end

  def notify_slack
    NotifySlackJob.perform_later "Ny ting!", [ as_slack_attachment ]
  end
end

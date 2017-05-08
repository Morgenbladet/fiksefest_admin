require 'routing'

class Comment < ApplicationRecord
  include Routing

  belongs_to :thing
  after_create :email_owner, :notify_slack

  validates :text, :name, :email, presence: true

  scope :published, -> { where(published: true) }

  def as_slack_attachment
    {
      fallback: "Kommentar av #{self.name}: '#{self.text}'",
      text: "<#{thing_url(self.thing)}|Kommentar ID #{self.id}>",
      fields: [
        { title: 'Kommentar', value: self.text },
        { title: 'Avsender' , value: self.name, short: true },
        { title: 'E-post',    value: self.email, short: true }
      ]
    }
  end

  private

  def email_owner
    ThingsMailer.new_comment(self).deliver_later
  end

  def notify_slack
    thing = self.thing
    NotifySlackJob.perform_later "*Ny kommentar*", [
      self.as_slack_attachment,
      thing.as_slack_attachment
    ]
  end
end

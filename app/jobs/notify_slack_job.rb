require 'slack'

class NotifySlackJob < ApplicationJob
  queue_as :default

  def perform(message, attachments)
    Slack.send_message message, attachments
  end
end

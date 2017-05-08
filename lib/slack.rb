class Slack
  def self.send_message(message, attachments=nil)
    uri = URI(ENV["SLACK_WEBHOOK_URL"])
    attachments ||= []
    payload = {
      "text": message,
      "channel": ENV["SLACK_WEBHOOK_CHANNEL"],
      "attachments": attachments
    }

    Net::HTTP.post uri, payload.to_json, "Content-Type": "application/json"
  end
end

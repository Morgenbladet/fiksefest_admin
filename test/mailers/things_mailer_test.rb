require 'test_helper'

class ThingsMailerTest < ActionMailer::TestCase
  test "accepted" do
    mail = ThingsMailer.accepted
    assert_equal "Accepted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "submitted" do
    mail = ThingsMailer.submitted
    assert_equal "Submitted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

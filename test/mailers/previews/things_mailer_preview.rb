# Preview all emails at http://localhost:3000/rails/mailers/things_mailer
class ThingsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/things_mailer/accepted
  def accepted
    ThingsMailer.accepted
  end

  # Preview this email at http://localhost:3000/rails/mailers/things_mailer/submitted
  def submitted
    ThingsMailer.submitted
  end

end

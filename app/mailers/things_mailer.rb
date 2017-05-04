class ThingsMailer < ApplicationMailer
  def accepted(thing)
    @url = "https://morgenbladet.no/fiksefest#/thing/#{thing.id}"
    mail to: thing.email, subject: "Fiksefest: Din ødelagte ting er publisert"
  end

  def submitted(thing)
    mail to: User.pluck(:email), subject: "Ny ting"
  end
end

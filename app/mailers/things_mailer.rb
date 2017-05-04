class ThingsMailer < ApplicationMailer
  def accepted(thing)
    @thing = thing
    @url = "https://morgenbladet.no/fiksefest#/thing/#{thing.id}"
    mail to: thing.email, subject: "Fiksefest: Din ødelagte ting er publisert"
  end

  def submitted(thing)
    @thing = thing
    mail to: User.pluck(:email), subject: "Ny ting"
  end
end

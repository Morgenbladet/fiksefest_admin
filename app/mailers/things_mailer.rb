class ThingsMailer < ApplicationMailer
  def accepted(thing)
    @thing = thing
    mail to: thing.email, subject: "Fiksefest: Din ødelagte ting er publisert"
  end

  def submitted(thing)
    @thing = thing
    mail to: User.pluck(:email), subject: "Ny ting"
  end

  def new_comment(comment)
    @comment = comment
    @thing = comment.thing
    mail to: @thing.email, subject: "Fiksefest: Ny kommentar"
  end
end

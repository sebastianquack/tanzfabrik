class RegistrationMailer < ActionMailer::Base
  default from: "admin@tanzfabrik-berlin.de"
  
  def registration_mail(registration)
    @registration = registration
    mail(to: "workshop@tanzfabrik-berlin.de", subject: "Workshop-Anmeldung")
    #mail(to: "sebastianquack@gmail.com", subject: "Workshop-Anmeldung")
  end
end

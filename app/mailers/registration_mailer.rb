class RegistrationMailer < ActionMailer::Base
  default from: "admin@tanzfabrik.de"
  
  def registration_mail(registration)
    @registration = registration
    mail(to: "sebastianquack@gmail.com, holgheiss@gmail.com", subject: "Workshop-Anmeldung")
  end
end

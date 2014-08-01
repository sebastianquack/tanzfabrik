class RegistrationMailer < ActionMailer::Base
  default from: "sebastianquack@gmail.com"
  
  def registration_mail(registration)
    @registration = registration
    mail(to: "sebastianquack@gmail.com", subject: "test")
  end
end

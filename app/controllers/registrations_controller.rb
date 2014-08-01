require 'mail'

class RegistrationsController < ApplicationController

  def create
    params.require(:registration).permit!
    
    @registration = Registration.new(params[:registration])

    if @registration.save
      
      # send mail
      Mail.defaults do
        delivery_method :smtp, {
          :address => 'smtp.sendgrid.net',
          :port => '587',
          :domain => 'heroku.com',
          :user_name => ENV['SENDGRID_USERNAME'],
          :password => ENV['SENDGRID_PASSWORD'],
          :authentication => :plain,
          :enable_starttls_auto => true
        }
      end
      
      Mail.deliver do
        to 'example@example.com'
        from 'sender@example.comt'
        subject 'testing send mail'
        body 'Sending email with Ruby through SendGrid!'
      end
      
      logger.debug @registration.workshop_1.workshop_select if @registration.workshop_1     
      logger.debug @registration.workshop_2.workshop_select if @registration.workshop_2             
            
      redirect_to page_url('workshop_anmeldung'), :notice => 'ok'
    else
      redirect_to page_url('workshop_anmeldung'), :notice => 'Fehler bei der Anmneldung.'
    end

  end

end

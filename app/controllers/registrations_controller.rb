class RegistrationsController < ApplicationController

  def create
    params.require(:registration).permit!
    
    @registration = Registration.new(params[:registration])

    if @registration.save
      
      RegistrationMailer.registration_mail(@registration).deliver
      
      logger.debug @registration.workshop_1.workshop_select if @registration.workshop_1     
      logger.debug @registration.workshop_2.workshop_select if @registration.workshop_2             
            
      redirect_to page_url('workshop_anmeldung'), :notice => 'ok'
    else
      redirect_to page_url('workshop_anmeldung'), :notice => 'Fehler bei der Anmneldung.'
    end

  end

end

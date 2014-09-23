class RegistrationsController < ApplicationController

  def create
    params.require(:registration).permit!

    # check for bot presence
    if (Time.now.to_i - params[:registration][:timestamp].to_i) < 2
      logger.debug "form submission too fast to be human, aborting"
      redirect_to page_url('workshop_anmeldung'), :notice => t(:registration_error)
      return
    end

    if params[:registration][:country] != ""
      logger.debug "form submission includes hidden country field, aborting"
      redirect_to page_url('workshop_anmeldung'), :notice => t(:registration_error)
      return      
    end

    # prepare params for record creation
    params[:registration].delete(:timestamp)
    params[:registration].delete(:country)
    
    @registration = Registration.new(params[:registration])

    if @registration.save
      
      RegistrationMailer.registration_mail(@registration).deliver
      
      logger.debug @registration.workshop_1.workshop_select if @registration.workshop_1     
      logger.debug @registration.workshop_2.workshop_select if @registration.workshop_2             
            
      redirect_to page_url('workshop_anmeldung'), :notice => 'ok'
    else
      redirect_to page_url('workshop_anmeldung'), :notice => t(:registration_error)
    end

  end

end

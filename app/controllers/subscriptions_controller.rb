class SubscriptionsController < ApplicationController

  def create

    # check for bot presence
    if (Time.now.to_i - params[:timestamp].to_i) < 2
      logger.debug "form submission too fast to be human, aborting"
      redirect_to page_url('newsletter'), :notice => 'error'
      return
    end

    if params[:country] != ""
      logger.debug "form submission includes hidden country field, aborting"
      redirect_to page_url('newsletter'), :notice => 'error'
      return      
    end

    subscription = Subscription.where(:email => params[:email]).first
    if(!subscription) 
      subscription = Subscription.new(:email => params[:email])
      subscription.save
    end 
    
    if params[:unsubscribe] == "on"
      subscription.status = false      
      subscription.newsletter_1 = false
      subscription.newsletter_2 = false
      subscription.newsletter_3 = false
    else
      subscription.status = true
      subscription.newsletter_1 = params[:newsletter_1]
      subscription.newsletter_2 = params[:newsletter_2]
      subscription.newsletter_3 = params[:newsletter_3]        
    end
    subscription.save
    
    SubscriptionMailer.subscription_mail(subscription).deliver                  
    #redirect_to page_url('newsletter'), :notice => 'ok' 
    redirect_back :notice => 'ok', fallback_location: '/', allow_other_host: false

  end

end

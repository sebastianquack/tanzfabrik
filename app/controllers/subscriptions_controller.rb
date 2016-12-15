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
      subscription = Subscription.new(:email => params[:email], :status => (params[:mode] == "subscribe"))
      subscription.save
    else 
      if subscription.status == true && params[:mode] == "unsubscribe"
        subscription.status = false
        subscription.save
      elsif subscription.status == false && params[:mode] == "subscribe"
        subscription.status = true
        subscription.save
      end
    end
    
    SubscriptionMailer.subscription_mail(params[:mode], params[:email]).deliver                  
    redirect_to page_url('newsletter'), :notice => 'ok' 

  end

end

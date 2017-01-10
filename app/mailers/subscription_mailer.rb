class SubscriptionMailer < ActionMailer::Base
  default from: "admin@tanzfabrik-berlin.de"
  
  def subscription_mail(subscription)
    @subscription = subscription
    to = TextItem.where(:name => "NewsletterAdmin").first
    
    if(to.content)
      mail(to: to.content, subject: "Newsletter-Update")
    end
    
  end
end

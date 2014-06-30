class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_background_image
 
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale] 
    elsif request.location.country_code == "DE" || request.location.country_code == "AT" || request.location.country_code == "CH"
      I18n.locale = :de
    else
      I18n.locale = I18n.default_locale
    end
  end

  def set_background_image
    @bg_image_url = ""
    
    festivals = Festival.where(:feature_on_welcome_screen => true)
    if festivals.length > 0
      if festivals.first.images.length > 0
        @bg_image_url = festivals.first.images.first.attachment.url(:medium)
        return
      end
    end

    events = Event.where(:feature_on_welcome_screen => true)
    if events.length > 0
      if events.first.images.length > 0
        @bg_image_url = events.first.images.first.attachment.url(:medium)
        return
      end
    end
        
    images = Image.where(:show_on_welcome_screen => true)
    if images.length > 0
      # hier müsste man noch täglich wechseln mit pseudorandom
      @bg_image_url = images.first.attachment.url(:medium)
      return
    end
    
  end
  
  def default_url_options(options={})
    #logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end
  
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
 
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale] 
    elsif request.location.country_code == "DE" || request.location.country_code == "AT" || request.location.country_code == "CH"
      I18n.locale = :de
    else
      I18n.locale = I18n.default_locale
    end
  end
  
  def default_url_options(options={})
    #logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end
  
end

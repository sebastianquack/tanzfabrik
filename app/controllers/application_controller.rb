class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  before_action :set_locale
  before_action :set_background_image
  before_action :set_time
  before_action :load_tree

  if Rails.env.production?
    rescue_from ActionController::RoutingError, :with => :raise_routing_404
  end

  def raise_routing_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale] 
    else
      I18n.locale = I18n.default_locale
    end
  end

  def set_background_image
    @bg_image_url = ""

    #festivals = Festival.where(:feature_on_welcome_screen => true)
    #if festivals.length > 0
    #  if festivals.first.images.length > 0
    #    @bg_image_url = festivals.first.images.first.attachment.url(:background)
    #    return
    #  end
    #end

    #events = Event.where(:feature_on_welcome_screen => true)
    #if events.length > 0
    #  if events.first.images.length > 0
    #    @bg_image_url = events.first.images.first.attachment.url(:background)
    #    return
    #  end
    #end
        
    images = Image.where(:show_on_welcome_screen => true)
    if images.length > 0
      # pseudorandom
      bgrand = Random.new(request.user_agent.length + Time.now.round_to_fifteen.to_i)
      max_rand = images.length > 1 ? images.length : 1
      @bg_image_url = images[bgrand.rand(max_rand)].attachment.url(:background)
      return
    end
    
  end

  def load_tree 
    @menu_tree = MenuItem.arrange(:order => :position)
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  def set_time
    if params[:t]
      if Rails.env.production?
        logger.debug("denied setting of time by URL parameter because running in production environment")
      else
        if params[:t].empty? or params[:t] == "now"
          Timecop.return
          logger.debug("application time reset")
        else
          t = Time.parse(params[:t])
          logger.debug("application time set by URL parameter to " + t.to_s)
          Timecop.travel(t)
        end
      end
    end
  end
  
end

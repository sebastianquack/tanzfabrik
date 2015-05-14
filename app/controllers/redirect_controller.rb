class RedirectController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require "yaml"
  FILENAME = 'config/redirects.yaml'

  def oldsite
    # defined redirects
    definitions = YAML.load_file(FILENAME)
    definitions.each do |locale, redirects|
      redirects.each do |page_id,urls|
        urls = [urls] if !urls.kind_of?(Array)
        urls.each do |url|
          if "/"+url == request.fullpath.to_s
            if page_id == "root"
              dest = root_url(:locale => locale)
            else
              dest = page_url(page_id, :locale => locale)
            end
            logger.info "redirected " + request.fullpath.to_s + " to " + dest
            redirect_to dest, status: :moved_permanently
            return
          end
        end
      end
    end

    # anything else
    redirect_to "http://archiv.tanzfabrik-berlin.de" + request.fullpath, status: :moved_permanently
  end

end

class RedirectController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require "yaml"
  FILENAME = 'config/redirects.yaml'

  def oldsite
    # defined redirects
    redirects = YAML.load_file(FILENAME)
    redirects.each do |page_id,urls|
      urls = [urls] if !urls.kind_of?(Array)
      urls.each do |url|
        logger.debug "/"+url + " == " + request.fullpath.to_s
        if "/"+url == request.fullpath.to_s
          if page_id == "root"
            dest = root_url(:locale => "de")
          else
            dest = page_url(page_id, :locale => "de")
          end
          redirect_to dest, status: :moved_permanently
          return
        end
      end
    end

    # anything else
    redirect_to "http://archiv.tanzfabrik-berlin.de" + request.fullpath
  end

end

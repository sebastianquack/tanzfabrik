module ApplicationHelper

  # Caches Arbre output.
  #
  # context - ActiveAdmin instance context
  # args    - Arguments passed to Rails.cache calls.
  #
  # Yielding the first time adds to the output buffer regardless of the
  # returned value. The missed cache must be handled carefully.
  #
  # Returns yielded Arbre on cache miss OR an HTML string wrapped in
  # an Arbre div on cache hit.
  def cache_arbre(context, *args)
    if controller.perform_caching
      if Rails.cache.exist?(*args)
        context.instance_eval do
          div(Rails.cache.read(*args))
        end
      else
        Rails.cache.write(*args, yield.to_s)
      end
    else
      yield
    end
  end

end

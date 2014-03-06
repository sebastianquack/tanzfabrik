class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_de, use: [:slugged, :finders]

  translates :title, :content
end

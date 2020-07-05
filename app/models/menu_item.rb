class MenuItem < ActiveRecord::Base
  translates :name  
  belongs_to :page, optional: true  
  has_ancestry :orphan_strategy => :rootify
end

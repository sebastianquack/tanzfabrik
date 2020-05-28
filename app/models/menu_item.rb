class MenuItem < ActiveRecord::Base
  translates :name  
  belongs_to :page  
  has_ancestry :orphan_strategy => :rootify
end

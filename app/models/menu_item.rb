class MenuItem < ActiveRecord::Base
  translates :name  
  belongs_to :page  
end

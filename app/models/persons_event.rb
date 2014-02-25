class PersonsEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :person
end

class PersonEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :person
  # default_scope { joins(:person).order('people.name ASC') } # how to make default order right?
end

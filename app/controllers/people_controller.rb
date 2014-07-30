class PeopleController < ApplicationController

  def show
    @person = Person.find(params[:id])
    set_meta_tags :title => (@person.name)
  end
  
end

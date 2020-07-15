class PeopleController < ApplicationController
  include SeoHelper

  def show
    @person = Person.find(params[:id])
    set_meta_tags :title => (@person.name)
    #set_meta_tags :description => auto_generate_description(@person.bio) if @persion.bio
  end
  
end

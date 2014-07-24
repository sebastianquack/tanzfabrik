module PagesHelper

  def xeditable? object = nil
    admin_user_signed_in?
  end

  def kurs_link(kurs)
    url_for :controller => 'pages', :action => 'show', :id => "kursplan", :anchor => "#{kurs.id}"
  end

  def person_link(person)
    #url_for :controller => 'pages', :action => 'show', :id => "kursplan", :anchor => "#{kurs.id}"
  end  

end

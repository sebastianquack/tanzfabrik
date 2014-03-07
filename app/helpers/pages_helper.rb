module PagesHelper

  def xeditable? object = nil
    admin_user_signed_in?
  end

end

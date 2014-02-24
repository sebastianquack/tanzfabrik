module Mercury
  module Authentication

    def can_edit?
      return admin_user_signed_in?
    end

  end
end

class BookingPermissionRequest < ActiveRecord::Base
  belongs_to :user


  def self.build_description_from_params(params)
    if params["permission_request_type"] == "rehearsal"
      return new.map_to_rehearsal_request_description(params)
    else
      return ""
    end
  end

  def map_to_rehearsal_request_description(params)
    return "
<b>Email:</b> #{params["user"]["email"]}\n
<b>First name:</b> #{params["user"]["first_name"]}\n
<b>Last name: #{params["user"]["last_name"]}\n
<b>Artist Bio:</b>\n
#{params["user"]["bio"]} \n
<b>Dance Practice:</b> \n
#{params["dance_practice_description"]} \n
<b>Intended Studio usage:</b>\n
#{params["studio_usage"]}
"
  end
end
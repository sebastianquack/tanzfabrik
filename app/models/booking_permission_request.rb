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
Email: #{params["user"]["email"]}\n
First name: #{params["user"]["first_name"]}\n
Last name: #{params["user"]["last_name"]}\n
Artist Bio:\n
#{params["user"]["bio"]} \n
Dance Practice: \n
#{params["dance_practice_description"]} \n
Intended Studio usage:\n
#{params["studio_usage"]}
"
  end
end

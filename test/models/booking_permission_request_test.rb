require 'test_helper'

class BookingPermissionRequestTest < ActiveSupport::TestCase
  test "build description from params" do
    params = {
      "user" => {
        "first_name"=>"john",
        "last_name"=>"doe",
        "phone_number"=>"+4917681338317",
        "billing_address"=>"",
        "website"=>"",
        "is_krk_registered"=>"0",
        "email"=>"test@gmail.com",
        "password"=>"[FILTERED]",
        "password_confirmation"=>"[FILTERED]",
        "bio"=>"adasd",
        "preferred_language"=>"english",
        "is_workshop_newsletter_registered"=>"0",
        "is_course_newsletter_registered"=>"0"
      },
      "dance_practice_description"=>"This is the dance practice",
      "studio_usage"=>"The is the studio usage",
      "permission_request_type" => "rehearsal",
      "commit"=>"Register!",
      "locale"=>"de"
    }
    description = BookingPermissionRequest.build_description_from_params(params)
    assert_match /Email: test@gmail.com/, description
    assert_match /First name: john/, description
    assert_match /Last name: doe/, description
    assert_match /Artist Bio:\s*adasd/, description
    assert_match /Dance Practice:\s*This is the dance practice/, description
    assert_match /Intended Studio usage:\s*The is the studio usage/, description
  end
end

require 'test_helper'

class BookingPermissionRequestTest < ActiveSupport::TestCase
  test "Correctly creates a permission request" do
    
    user = users(:one)
    description = "This is a test description"

    assert_difference 'BookingPermissionRequest.count', 1 do
      BookingPermissionRequest.create(user: user, status: 'pending', permission_type: 'rehearsal', description: description)
    end

    created_request = BookingPermissionRequest.last
    assert_equal user.id, created_request.user_id
    assert_equal 'pending', created_request.status
    assert_equal 'rehearsal', created_request.permission_type
    assert_equal description, created_request.description
  end

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

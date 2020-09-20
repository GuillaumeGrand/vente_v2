require 'test_helper'

class StripesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stripes_new_url
    assert_response :success
  end

end

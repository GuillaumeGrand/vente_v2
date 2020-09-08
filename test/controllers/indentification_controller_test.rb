require 'test_helper'

class IndentificationControllerTest < ActionDispatch::IntegrationTest
  test "should get identification" do
    get indentification_identification_url
    assert_response :success
  end

end

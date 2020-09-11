require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest

test "signup page and create a user account" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count',1 do
        post users_path, params: { user: { username: "xyz",email:"xyz@gmail.com",password:"password" } }
        @user=User.new( username: "xyz",email:"xyz@gmail.com",password:"password")
        sign_in_as(@user)
        assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "xyz",response.body
end



end
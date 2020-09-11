require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
    setup do
    @user=User.create( username: "xyz",email:"xyz@gmail.com",password:"password")
    sign_in_as(@user)
    end

    test "get article new page and creation" do
            get '/articles/new'
            assert_response :success
            assert_difference '@user.articles.count',1 do
            post articles_path,params: {article: {title:"valid title",description:"valid description"} }
            assert_response :redirect
            end
            follow_redirect!
            assert_response :success
            assert_match "by xyz",response.body
            assert_select "a[href=?]",user_path(@user)
    end

    test "get article new page and invalid" do
        get '/articles/new'
        assert_response :success
        assert_no_difference '@user.articles.count' do
            post articles_path,params: {article: {title:"",description:""} }
        end
        assert_match "error",response.body
        assert_select 'div.alert'
        assert_select 'h4.alert-heading'
    end
end




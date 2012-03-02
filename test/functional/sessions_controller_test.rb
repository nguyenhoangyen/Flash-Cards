require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create new session (login) with valid user" do
    user = User.create( email: "test@test.com", password: "secret", registered: true )
    post :create, email: "test@test.com", password: "secret"
    
    assert_equal user.id, session[:user_id]
    assert_redirected_to decks_path
  end
  
  test "should not create new session (login) with invalid user" do
    user = User.create( email: "test@test.com", password: "secret" )
    post :create, email: "test@test.com", password: "badsecret"
    
    assert_equal nil, session[:user_id]
    assert_redirected_to new_session_path
  end
  
  test "should not create new session if not registered" do
    user = User.create( email: "test@test.com", password: "secret", emailed_at: Time.now )
    post :create, email: "test@test.com", password: "secret"
    
    assert_redirected_to new_session_path
  end
  
  test "should not send new email if one was just sent" do
    user = User.create( email: "test@test.com", password: "secret", emailed_at: Time.now )
    
    assert_no_difference('ActionMailer::Base.deliveries.size') do
      post :create, email: "test@test.com", password: "secret"  
    end
  end
  
  test "should send new email if one was sent 6 minutes ago" do
    user = User.create( email: "test@test.com", password: "secret", emailed_at: Time.now - 6.minutes )
    
    assert_difference('ActionMailer::Base.deliveries.size') do
      post :create, email: "test@test.com", password: "secret"  
    end
  end
  
  test "should destroy session (logout)" do
    delete :destroy
    assert_equal nil, session[:user_id]
    assert_redirected_to root_path
  end

end










load File.dirname(__FILE__) + '/../spec_helper.rb'

describe 'Authorize', :feature => "Authorize feature", :severity => :normal do
include SpecHelper

 before(:all) do
  @auth = Auth.new(@browser)
 end

  it 'should logged_in', :story => "Auth story", :severity => :critical do |e|
     e.step "enter exist?" do
     expect(@auth.enter_button.exist?).to be(true)
	   end
	   e.step "call auth form" do
     @auth.enter_button.click
	   end
	   e.step "type login and password" do
     @auth.authorize('username', 'password')
	   end
	   e.step "submit button is available?" do
     expect(@auth.submit.enabled?).to be(true)
	   end
	   e.step "click submit button" do
     @auth.submit.click
     end
     e.step "are we logged in?" do
     expect(@auth.user_snippet.exist?).to be(true)
     end
   end

  it 'should logout', :story => "Auth story", :severity => :normal do |e|
     e.step "if logout then login" do
     @auth.log_in('username', 'password')
     end
     e.step "exit exist?" do
     expect(@auth.logout_button.exist?).to be(true)
     end
     e.step "so exit" do
     @auth.user_snippet.hover
     @auth.logout_button.click
     end
     e.step "are we logout? enter button exist?" do
     expect(@auth.enter_button.exist?).to be(true)
     end
  end

   it 'should NOT logged_in', :story => "Auth story", :severity => :normal do |e|
     e.step "if logged then logout" do
     @auth.logout(@base_url)
     end
     e.step "enter exist?" do
     expect(@auth.enter_button.exist?).to be(true)
     end
	   e.step "call auth form" do
     @auth.enter_button.click
	   end
	   e.step "login with login 'alex.smap@gmail.com' and empty password" do
     @auth.authorize('username', '')
	   end
	   e.step "submit button should be disabled" do
     expect(@auth.submit.disabled?).to be(true)
	   end
   end

  it 'should get auth error', :story => "Auth story", :severity => :normal do |e|
    e.step "if logged then logout" do
    @auth.logout(@base_url)
    end
    e.step "enter exist?" do
    expect(@auth.enter_button.exist?).to be(true)
    end
    e.step "call auth form" do
    @auth.enter_button.click
    end
    e.step "sign in with login 'username' and password 'test' (wrong password)" do
    @auth.authorize('username', 'test')
    end
    e.step "submit button is available?" do
    expect(@auth.submit.enabled?).to be(true)
    end
    e.step "click submit button" do
    @auth.submit.click
    end
    e.step "have see auth error text" do
    expect(@auth.auth_error).to be(true)
    end
  end
end
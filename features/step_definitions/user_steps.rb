def create_visitor
  @visitor ||= { :name => "lejun", :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "Username", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

# sign up

Given(/^I am not logged in$/) do
  visit root_path
end

When(/^I sign up with valid user data$/) do
  create_visitor
  sign_up
end

Then(/^I should see a successful sign up message$/) do
  page.should have_content "Welcome! You have signed up successfully."
end

When(/^I sign up with an invalid email$/) do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

Then(/^I should see an invalid email message$/) do
  page.should have_content "Email is invalid"
end

When(/^I sign up without a password$/) do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

Then(/^I should see a missing password message$/) do
  page.should have_content "Password can't be blank"
end

When(/^I sign up without a password confirmation$/) do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

Then(/^I should see a missing password confirmation message$/) do
  page.should have_content "Password confirmation doesn't match Password"
end

When(/^I sign up with a mismatched password confirmation$/) do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

Then(/^I should see a mismatched password message$/) do
  page.should have_content "Password confirmation doesn't match Password"
end

# Sign in steps
Given(/^I do not exist as a user$/) do
  create_visitor
  delete_user
end

When(/^I sign in with valid credentials$/) do
  create_visitor
  sign_in
end

Then(/^I see an invalid login message$/) do
  page.should have_content "Invalid email or password."
end

Then(/^I should be signed out$/) do
  page.should have_content "Sign up"
  page.should have_content "Sign in"
  page.should_not have_content "Sign out"
end

Given(/^I exist as a user$/) do
  create_user
end

Then(/^I see a successful sign in message$/) do
  page.should have_content "Signed in successfully."
end

When(/^I return to the site$/) do
  visit '/'
end

Then(/^I should be signed in$/) do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

When(/^I sign in with a wrong email$/) do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When(/^I sign in with a wrong password$/) do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end



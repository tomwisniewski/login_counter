ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'database_cleaner'
require_relative '../../lib/controllers/login_counter'
require_relative '../spec_helper'

RSpec.configure do |config|

  config.include SpecHelper

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Capybara.app = LoginCounter

describe 'the login counter', :type => :feature do

  it "should sign up a user with valid details" do
    sign_up_user
    page.should have_content('Welcome')
  end

  it "should not sign up a user with invalid details" do
    visit '/'
    fill_in :first_name, :with => "Tom"
    fill_in :last_name, :with => "Wisniewski"
    fill_in :email, :with => "tom@gmail.com"
    fill_in :password, :with => "password"
    fill_in :password_confirmation, :with => "pass"
    click_button 'Sign Up'
    page.should have_content('Password does not match the confirmation')
  end

  it "should log in a user with valid details and redirect them to their login count page" do
    sign_up_user
    visit '/'
    log_in_user
    page.should have_content('This is your first log in!')
  end  

  it "should show an error message if a user tries to log in with invalid details" do
    sign_up_user
    visit '/'
    fill_in :login_email, :with => "tom@gmail.com"
    fill_in :login_password, :with => "pass"
    click_button 'Log In'
    page.should have_content('Your email and/or password is incorrect')
  end  

  it "should increment the login count each time the user logs in" do
    sign_up_user
    visit '/'
    log_in_user
    page.should have_content('This is your first log in!')
    click_link 'Sign Out'
    visit '/'
    log_in_user
    page.should have_content('You have logged in 2 times')
  end

  it "should not allow the user to visit the home page whilst logged in" do
    sign_up_user
    visit '/'
    log_in_user
    visit '/'
    page.should have_content('This is your first log in!')
  end

  it "should display a farewell message when the user logs out" do
    sign_up_user
    visit '/'
    log_in_user
    click_link 'Sign Out'
    page.should have_content('Goodbye!')
  end  
end  
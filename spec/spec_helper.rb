# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl'

FactoryGirl.find_definitions
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  #config.order = "random"
  config.formatter = :documentation

  config.include Capybara::DSL
end

browser = Capybara.current_session.driver.browser
if browser.respond_to?(:clear_cookies)
  # Rack::MockSession
  browser.clear_cookies
elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
  # Selenium::WebDriver
  browser.manage.delete_all_cookies
else
  raise "Don't know how to clear cookies. Weird driver?"
end


def create_listing_as_admin
  create_admin
  sign_in_admin
  create_listing
end

def create_listing
  visit '/listings/new'
  #puts page.html
  expect(current_path).to eq '/listings/new'
  fill_in "Title", with: "Macbook"
  fill_in "Description", with: "this is a really nice macbook"
  fill_in "Starting price", with: 1
  fill_in "RRP", with: 1340
  fill_in "Time per bid", with: 10
  #page.attach_file("Photo", '/Users/dev/Documents/prog/makersacademy/crazybid/app/assets/images/macbook.jpg')
  page.attach_file("Photo", '/Users/jeremygoh/macbook.jpg')
  click_on "Submit"
end

def signout
  visit '/signout'
end

def sign_in_admin
  visit "/signin"
  fill_in "User name", with: "rob123"
  fill_in "Password", with: "12345678"
  click_on "Sign in"
end

def sign_in_non_admin
  visit "/signin"
  fill_in "User name", with: "bobby123"
  fill_in "Password", with: "87654321"
  click_on "Sign in"
end

def create_user
#this method creates a user and logs it in
    visit "/signup"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Johnson"
    fill_in "User name", with: "rob123"
    fill_in "Email", with: "1@ex.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_on "Create my account"
    create_admin
end

def create_user_non_admin
#this method creates a user and logs it in
    signout
    visit "/signup"
    fill_in "First name", with: "Bobby"
    fill_in "Last name", with: "Jonny"
    fill_in "User name", with: "bobby123"
    fill_in "Email", with: "123@ex.com"
    fill_in "Password", with: "87654321"
    fill_in "Password confirmation", with: "87654321"
    click_on "Create my account"
end


def create_admin
    last_user = User.last
    last_user.admin = true
    last_user.save
    expect(User.last.admin).to eq true
end
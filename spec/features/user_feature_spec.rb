require 'spec_helper'

User.delete_all

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


def create_listing_and_login_non_admin
  create_user
  create_admin
  sign_in_admin
  create_listing
  signout
  create_user_non_admin
end


describe 'User not logged in' do
	describe '/' do
		it 'should not show the account link' do
			visit '/'
      expect(page).to have_no_content 'Account'
		end
		it 'should not show the bank link' do
			visit '/'
      expect(page).to have_no_content 'Bank'
		end
		it 'should show the login link' do
			visit '/'
			expect(page).to have_content 'Sign In'
		end
		it 'should show the signup link' do 
			visit '/'
			expect(page).to have_content 'Register'
		end
	end

	describe '/signup' do
		it 'should have the correct fields' do
			visit '/signup'
			expect(page).to have_field('First name')
			expect(page).to have_field('Last name')
			expect(page).to have_field('User name')
			expect(page).to have_field('Email')
			expect(page).to have_field('Password')
		end
		it 'should be able to add a user' do
			create_user
    	expect(page).to have_content('Welcome! You have signed up successfully')
		end
		it 'should not be able to have a duplicate email address' do
			create_user
			signout
			create_user
    	expect(page).to have_css('li', text: 'Email has already been taken')
		end
	end
	describe '/signin' do
		before(:all){create_user}
		it 'should be able to log in a user' do
			create_user_non_admin
			signout
			visit '/signin'
			within("#new_user") do
				fill_in('user_user_name', :with => 'bobby123')
				fill_in('Password', :with => '87654321')
			end
			click_button('Sign')
			expect(page).to have_content('Welcome back, Bobby')
		end
	end
end

describe 'User logged in' do
	#before(:all){log_in_test_user}
	describe '/' do
		it 'should greet a user' do
			create_user_non_admin
			signout
			visit '/signin'
			within("#new_user") do
				fill_in('user_user_name', :with => 'bobby123')
				fill_in('Password', :with => '87654321')
			end
			click_button('Sign')
			expect(page).to have_content('Welcome back, Bobby')
		end
		it 'should display the account link' do
			create_user_non_admin
			visit '/'
			expect(page).to have_content('Account')
		end
		it 'should display the profile link' do
			create_user_non_admin
			visit '/'
			expect(page).to have_content('Profile')
		end
		it 'should diplay the log-out link' do
			create_user_non_admin
			visit '/'
			click_link('Sign Out')
			expect(page).to have_no_css('h2', text: 'Hi, User1')
		end
		xit 'should show a credits item' do
			visit '/'
			expect(page).to have_css('div', name:'credit-box')
		end
	end
end
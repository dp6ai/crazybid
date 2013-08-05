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

def add_test_user
	visit '/signup'
			within("#new_user") do
				fill_in('user_first_name', :with => 'Kips')
				fill_in('user_last_name', :with => 'Davenport')
				fill_in('user_user_name', :with => 'user1')
				fill_in('Email', :with => 'user1@mail.com')
	    	fill_in('Password', :with => 'pa55word')
	    	fill_in('user_password_confirmation', :with => 'pa55word')
	    end
	click_button('Create')
end

describe 'User not logged in' do
	describe '/' do
		it 'should not show the account link' do
			visit '/'
      expect(page).to_not have_no_content 'Account'
		end
		it 'should not show the bank link' do
			visit '/'
      expect(page).to_not have_no_content 'Bank'
		end
		it 'should show the login link' do
			visit '/'
			expect(page).to have_content 'Log In'
		end
		it 'should show the signup link' do 
			visit '/'
			expect(page).to have_content 'Sign Up'
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
			visit '/signup'
			within("#new_user") do
				fill_in('user_first_name', :with => 'Kips')
				fill_in('user_last_name', :with => 'Davenport')
				fill_in('user_user_name', :with => 'user1')
				fill_in('Email', :with => 'user1@mail.com')
	    	fill_in('Password', :with => 'pa55word')
	    	fill_in('user_password_confirmation', :with => 'pa55word')
	    end
	    click_button('Create')
    	expect(page).to have_css('p', text: 'Welcome! You have signed up successfully')
		end
		it 'should not be able to have a duplicate email address' do
			add_test_user
			visit '/signup'
			within("#new_user") do
				fill_in('user_first_name', :with => 'Kips')
				fill_in('user_last_name', :with => 'Davenport')
				fill_in('user_user_name', :with => 'user1')
				fill_in('Email', :with => 'user1@mail.com')
	    	fill_in('Password', :with => 'pa55word')
	    	fill_in('user_password_confirmation', :with => 'pa55word')
	    end
    	click_button('Create')
    	expect(page).to have_css('li', text: 'Email has already been taken')
		end
	end
	describe '/signin' do
		before(:all){add_test_user}
		xit 'should be able to log in a user' do
			visit '/signin'
			within("#new_user") do
				fill_in('user_user_name', :with => 'user1')
				fill_in('Password', :with => 'pa55word')
			end
			click_button('Sign')
			expect(page).to have_css('p', text: 'Welcome! You have signed up successfully')
		end
	end
end

describe 'User logged in' do
	#before(:all){log_in_test_user}
	describe '/' do
		xit 'should greet a user' do
			visit '/'
			expect(page).to have_css('h2', text: 'Hi, User1')
		end
		xit 'should display the account link' do
			visit '/'
			click_link('Account')
			expect(page).to have_title('Account')
		end
		xit 'should display the bank link' do
			visit '/'
			click_link('Bank')
			expect(page).to have_title('Bank')
		end
		xit 'should diplay the log-out link' do
			visit '/'
			click_link('Log Out')
			expect(page).to have_no_css('h2', text: 'Hi, User1')
		end
		xit 'should show a credits item' do
			visit '/'
			expect(page).to have_css('div', name:'credit-box')
		end
	end
end
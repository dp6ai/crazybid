require 'spec_helper'

def add_test_user
		User.create(
		first_name:'Dave',
		last_name: 'Smith',
		user_name: 'user123',
		email: 'dave@mail.com',
		password: 'pa55word'
		)
end

def log_in_test_user
	visit '/sign-in'
	fill_in('User name', :with => 'user1')
	fill_in('Password', :with => 'pa55word')
	click_link('Sign In')
end


describe 'User not logged in' do
	describe '/' do
		it 'should not show the account link' do
			visit '/'
      expect(page).to_not have_no_content 'Account'
		end
		xit 'should not show the bank link' do
			visit '/'
      expect(page).to_not have_no_content 'Bank'
		end
		xit 'should show the login link' do
			visit '/'
			expect(page).to have_content 'Log In'
		end
		xit 'should show the sign-up link' do 
			visit '/'
			expect(page).to have_content 'Sign Up'
		end
	end

	describe '/sign-up' do
		before(:all){add_test_user}

		xit 'should have the correct fields' do
			visit '/sign-up'
			expect(page).to have_field('First name')
			expect(page).to have_field('Last name')
			expect(page).to have_field('User name')
			expect(page).to have_field('Email')
			expect(page).to have_field('Password')
		end
		xit 'should be able to add a user' do
			visit '/sign-up'
			fill_in('First Name', :with => 'Kips')
			fill_in('Last Name', :with => 'Davenport')
			fill_in('User Name', :with => 'user1')
			fill_in('Email', :with => 'user1@mail.com')
    	fill_in('Password', :with => 'pa55word')
    	click_link('Sign Up')
    	expect(page).to have_css('h2', text: 'Hi, User1')
		end
		xit 'should not be able to have a duplicate user name' do
			visit '/sign-up'
			fill_in('First Name', :with => 'Kips')
			fill_in('Last Name', :with => 'Davenport')
			fill_in('User Name', :with => 'user123')
			fill_in('Email', :with => 'user1@mail.com')
    	fill_in('Password', :with => 'pa55word')
    	click_link('Sign Up')
    	expect(page).to have_css('h2', text: 'This user name has already been taken')
		end		
		xit 'should not be able to have a duplicate email address' do
			visit '/sign-up'
			fill_in('First Name', :with => 'Kips')
			fill_in('Last Name', :with => 'Davenport')
			fill_in('User Name', :with => 'user1')
			fill_in('Email', :with => 'dave@mail.com')
    	fill_in('Password', :with => 'pa55word')
    	click_link('Sign Up')
    	expect(page).to have_css('h2', text: 'This email address has already been registered')
		end
	end
	describe '/sign-in' do
		xit 'should be able to log in a user' do
			visit '/sign-in'
			fill_in('User name', :with => 'user1')
			fill_in('Password', :with => 'pa55word')
			click_link('Sign In')
			expect(page).to have_css('h2', text: 'Hi, User1')
		end
	end
end

describe 'User logged in' do
	before(:all){log_in_test_user}
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
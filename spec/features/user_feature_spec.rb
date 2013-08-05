require 'spec_helper'

describe 'User not logged in' do
	describe '/' do
		it 'should not show the account link' do
			visit '/'
      expect(page).to_not have_no_content  'Account'
		end
		xit 'should not show the bank link' do

		end
		xit 'should show the login link' do

		end
		xit 'should show the sign-up link' do 

		end
	end

	describe '/sign-up' do
		xit 'should have the correct fields' do

		end
		xit 'should be able to add a user' do

		end

	end
	describe '/sign-in' do
		xit 'should be able to log in a user' do

		end
	end
end

describe 'User logged in' do
	describe '/' do
		xit 'should greet a user' do

		end
		xit 'should display the account link' do

		end
		xit 'should display the bank link' do

		end
		xit 'should diplay the log-out link' do

		end
		xit 'should show a credits item' do

		end
	end
end
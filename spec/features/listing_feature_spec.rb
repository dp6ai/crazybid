require 'spec_helper'

def create_listing
  #this method creates an admin and also a listing
  visit '/listing/new'
end

def logout_admin
end

def create_user
#this method creates a user and log it in
end


describe "Listings" do

    context "creating listing" do

        context "as admin" do

            xit "should allow an admin to create a listing" do
                create_listing
                visit '/'
                expect(Listing.count).to eq 1
                expect(page).to have_content #releated to listing
                click_on #listing 1
                expect(page).to have_content #related to listing
            end

            xit "shouldn't allow you to create a listing if not all forms filled in" do
                #do we need multiple tests for all the possible not filled properly combos?
            end

        end

        context "not as admin" do


            it "should not allow a user to create a listing" do
                visit "/listings/new"
                expect(current_path).to eq "/"
            end

        end

    end


    context "editing listing" do

        context "as admin" do

            xit "should allow an admin to edit a listing" do
                create_listing
                visit '/listings/1'
                click_on "Edit" #so we want an edit link on the page if admin?
                fill_in #some change
                click_on "Update"
                visit "/"
                expect(page).to have_content #related to updated listing
                visit "/listings/1"
                expect(page).to have_content #related to updated listing
            end
        end

        context "not as admin" do

            xit "should not allow non-admins to see edit button" do
                create_listing
                logout_admin
                create_user
                visit "/listings/1"
                expect(page).not_to have_css("button", text: "Edit")
            end

            xit "should not allow non-admins to view edit form" do
                create_listing
                logout_admin
                create_user
                visit "/listings/1/edit"
                expect(current_path).to eq "/"  #it should redirect
            end

        end

    end

    context "deleting listing" do

        context "as admin" do

            xit "should allow a listing to be deleted if logged in as admin" do
                create_listing
                visit '/listings/1'
                click_on "Delete"
                expect(Listing.count).to eq 0 #we want to remove the listing right? Not just disable?
                visit '/'
                expect(page).not_to have_content #related to listing 1
            end

        end

        context "not as admin" do

            xit "should not allow a listing to be deleted if not logged in as admin" do
                create_listing
                logout_admin
                create_user
                visit '/listings/1'
                click_on "Delete"
                expect(Listing.count).not_to eq 0
                visit '/'
                expect(page).to have_content #listing content should still be there
            end

        end

    end

    context "viewing listing" do

        context "it has listings" do  

            xit "should display six active listings on the root page" do
                visit "/"
                #expect listings?
            end

            xit "should allow you to view individual listing page" do
                create_listing
                visit "/"
                click_on ##view a particular listing
                expect(page).to have_content #listing details
            end
            
        end

        context "it has no listings" do

            xit 'should display a message saying there are no listings' do
                visit '/'
                expect(page).to have_content "No listings"
            end 

            xit "should not be able to view a non-existent listing" do
                visit "/listings/1"
                expect(current_path).to eq "/"
            end

        end

    end

end
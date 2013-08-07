require 'spec_helper'



fake_time = Time.new(2013,8,6, 8,30,0)


describe "Listings" do

    context "creating listing" do

        context "as admin" do

            it "should allow an admin to create a listing" do
                create_listing
                expect(Listing.count).to eq 1
            end

            context "created listing" do

                it "should automatically have the time left and current price saved
                and also have the initial duration set to 24 hours from the current time" do
                    Time.stub(:now) { fake_time }
                    create_listing
                    Listing.last.current_price.should eq 1
                    Listing.last.start_date.should eq fake_time
                    Listing.last.duration.should eq 86400
                end


                it "should have the new listing on the index" do
                    create_listing
                    visit '/'
                    expect(page).to have_content "Macbook"
                    expect(page).to have_content "1"
                end

                it "should have the new listing information on its own page which you can click through" do
                    create_listing
                    visit '/'
                    click_on "Macbook"
                    expect(current_path).to eq "/listings/#{Listing.last.id}"
                    expect(page).to have_content "Macbook"
                end    
            end

            it "shouldn't allow you to create a listing if not all forms filled in" do
                  create_admin
                  visit '/listings/new'
                  click_on "Submit"
                  expect(Listing.count).not_to eq 1
                  expect(page).to have_content "Title can't be blank"
                  expect(page).to have_content "Description can't be blank"
                  expect(page).to have_content "Starting price can't be blank"
                  expect(page).to have_content "Rrp can't be blank"
                  expect(page).to have_content "Time per bid can't be blank"
                  expect(page).to have_content "Photo can't be blank"
             end

            it "shouldn't allow a listing to be created with negative number for rrp, starting price or time per bid" do
                create_admin
                visit '/listings/new'
                fill_in "Title", with: "Macbook"
                fill_in "Description", with: "this is a really nice macbook"
                fill_in "Starting price", with: -1
                fill_in "RRP", with: -1
                fill_in "Time per bid", with: -1
                click_on "Submit"
                expect(Listing.count).not_to eq 1
                expect(page).to have_content "Starting price must be greater than 0"
                expect(page).to have_content "Rrp must be greater than 0"
                expect(page).to have_content "Time per bid must be greater than 0"
            end

        end
        
        describe ListingsController, type: :controller do

                context "not as admin"do

                    it "should not allow a user to create a listing" do
                        visit "/listings/new"
                        expect(current_path).to eq "/"
                    end

                    it "should not allow a user to post to the create" do
                        post('create', {:listing=>{"title"=>"e", "description"=>"e", "starting_price"=>"1", "rrp"=>"1", "time_per_bid"=>"1"}})
                        expect(Listing.count).not_to eq 1
                    end

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
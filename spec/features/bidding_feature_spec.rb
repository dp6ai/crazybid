require 'spec_helper'

describe "Bidding process" do

    context "bid button" do

        it "should display the bid button on a current listing's page" do
            create_listing
            visit '/listing/1'
            expect(page).to have_css("button", text: "Bid") #can change the text/css
            #should show bid button even if not a user
        end



        it "should not display the bid button on a coming soon listing page" do
            #add a coming soon listing
            visit '/listing/1'
            expect(page).not_to have_css("button", text: "Bid") #or expect the button to be disabled?
        end

        it "should not display the bid button on an expired listing page" do
            #add an expired listing
            visit '/listing/1'
            expect(page).not_to have_css("button", text: "Bid") #or expect the button to be disabled?
        end

    end

    context "Failure" do

        context "not signed up" do

            it "should redirect to login/signup if try to make a bid" do
                visit '/listing/1'
                click_on 'Bid'
                expect(current_path).to eq "/login" #or are we expecting a popup?
            end

        end

        context "not enough credits" do

            it "should not allow a bid to be made if not enough credits" do
                #have a user with not enough credits
                expect(current_path).to eq "/user/1/bank" #or add credits. Or are we expecting a pop up
                expect(Listing.last.bids.size).not_to eq 1  #so no bid should have registered
                expect(Listing.last.price).not_to eq #blah. #so no change to price
                expect(Listing.last.time).not_to eq #some increase in price
            end

        end

        context "expired ad or coming soon ad" do   #i.e. can't make a post request to the page. Is this even necessary?!
            
            it "should not allow a bid to be made if the ad is expired" do
                #add expired listing
                expect(Listing.last.bids.size).not_to eq 1  #so no bid should have registered
                expect(Listing.last.price).not_to eq #blah. #so no change to price
                expect(Listing.last.time).not_to eq #some increase in price
            end

            it "should not allow a bid to be made if the ad is coming soon" do
                #add coming soon listing
                expect(Listing.last.bids.size).not_to eq 1  #so no bid should have registered
                expect(Listing.last.price).not_to eq #blah. #so no change to price
                expect(Listing.last.time).not_to eq #some increase in price
            end

        end

    end


    context "Success" do

        it "should increase price if a successful bid is made" do
            create_listing
            visit "/listing/1"
            click_on "Bid"
            user.bid(Listing.last)
            expect(Listing.last.bids.size).to eq 1
            expect(Listings.last.price).to eq ##some increase in price
        end

        it "should increase time if a successful bid is made" do
            create_listing
            visit "/listing/1"
            click_on "Bid"
            user.bid(Listing.last)
            expect(Listing.last.bids.size).to eq 1
            expect(Listing.last.time).to eq #some increase in time
        end

    end


end 
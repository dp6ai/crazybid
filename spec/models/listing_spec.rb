require 'spec_helper'

describe Listing do
  
    describe "validations" do
        it { should validate_presence_of :title }
        it { should validate_presence_of :description }
        it { should validate_presence_of :starting_price}
        it { should validate_presence_of :current_price }
        it { should validate_presence_of :rrp }
        it { should validate_presence_of :start_date }
        it { should validate_presence_of :duration }
        it { should validate_presence_of :time_per_bid }
        it { should validate_presence_of :default_end_date }
    end

end


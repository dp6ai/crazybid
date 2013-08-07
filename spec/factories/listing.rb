# This will guess the User class
FactoryGirl.define do
  factory :listing do
    title "iphone5"
    description  "ldskhfg lasdfjasfl jasldfj alskjdf lakdsjf lasdkjf lasdk"
    starting_price "100"
    rrp "500"
    start_date "10/10/2013"
    duration false
    time_per_bid 30
  end
end
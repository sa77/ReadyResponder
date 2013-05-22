# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "EMA-10"
    description "Ford F-150"
    source "Stoneham Ford"
    category "Vehicle"
    model "F-150"
    serial "VIN123456789"
    purchase_date "2010-12-14"
    purchase_amt ""
    status "Available"
    person
    location
  end
end
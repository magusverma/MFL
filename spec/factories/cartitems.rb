FactoryGirl.define do
  factory :cartitem do
    cart nil
item nil
review_quality_rating 1
review_quantity_rating 1
review_comment "MyText"
quantity 1.5
price 1
item_name "MyString"
  end

end

FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body "Lorem, etc."
  end

  factory :person do
    name "Marty McFly"
    email "backin@time.com"
    location "Hill Valley, California"
    age 17
  end

  factory :pidgeon do
    name "Bob"
    location "Everywhere"
  end
end

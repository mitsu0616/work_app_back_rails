FactoryBot.define do
  factory :user do
    trait :a do
      id { 1 }
      name { 'tanaka' }
      mail { 'tanaka@sample.com' }
    end
    trait :b do
      id { 2 }
      name { 'sato' }
      mail { 'sato@sample.com' }
    end
  end
end

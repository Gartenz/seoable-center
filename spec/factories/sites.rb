FactoryBot.define do
  factory :site do
    url { "https://github.com" }

    trait :invalid do
      url { nil }
    end
  end
end

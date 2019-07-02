FactoryBot.define do
  factory :page do
    site
    url { "https://github.com" }
    body { "MyText" }
  end
end

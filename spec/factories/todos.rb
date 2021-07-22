FactoryBot.define do
  factory :todo do
    title { 'MyString' }
    status { false }
    ownerable_id { nil }
    ownerable_type { nil }
  end
end

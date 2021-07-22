FactoryBot.define do
  factory :todo do
    title { 'MyString' }
    status { false }
    user { nil }
    user_group { nil }
  end
end

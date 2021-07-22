# frozen_string_literal: true

FactoryBot.define do
  factory :user_group_user do
    user { nil }
    user_group { nil }
  end
end

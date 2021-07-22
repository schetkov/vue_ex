# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Name' }
    email { 'email@email.com' }
    password { 'Password' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    title { 'MyTODO' }
    status { 'Created' }
    ownerable_id { ownerable_id }
    ownerable_type { ownerable_id }
  end
end

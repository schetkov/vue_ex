# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :ownerable, polymorphic: true # questionable

  enum status: ['Created', 'Taken', 'In progress', 'Done']

  scope :by_owner_params, -> (params) { where(params) }


  validates :title, presence: true
end

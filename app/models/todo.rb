class Todo < ApplicationRecord
  belongs_to :ownerable, polymorphic: true # questionable
end

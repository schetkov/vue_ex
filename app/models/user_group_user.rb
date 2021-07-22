# frozen_string_literal: true

class UserGroupUser < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :user_group, class_name: 'UserGroup'
end

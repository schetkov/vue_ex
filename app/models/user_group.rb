class UserGroup < ApplicationRecord
  has_many :user_group_users, class_name: 'UserGroupUser'
  has_many :users, class_name: 'User', through: :user_group_users

  has_many :todos, as: :ownerable
end

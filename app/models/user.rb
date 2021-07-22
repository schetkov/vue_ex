class User < ApplicationRecord
  has_secure_password
  has_many :user_group_users
  has_many :groups, class_name: 'UserGroup', through: :user_group_users, source: :user_group

  validates :name, presence: true
  validates :email, presence: true
end

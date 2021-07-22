# frozen_string_literal: true

class CreateUserGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :user_groups do |t|
      t.string :title

      t.timestamps
    end
  end
end

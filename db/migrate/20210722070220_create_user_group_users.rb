class CreateUserGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_group_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end

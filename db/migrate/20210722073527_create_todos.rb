class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :status
      t.integer :ownerable_id
      t.string :ownerable_type
      t.timestamps
    end

    add_index :todos, %i[ownerable_type ownerable_id]
  end
end

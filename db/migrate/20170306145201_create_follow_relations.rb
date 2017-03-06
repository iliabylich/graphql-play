class CreateFollowRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_relations do |t|
      t.integer :follower_id, null: false
      t.integer :following_id, null: false
    end

    add_foreign_key :follow_relations, :users, column: :follower_id, on_delete: :cascade
    add_foreign_key :follow_relations, :users, column: :following_id, on_delete: :cascade
  end
end

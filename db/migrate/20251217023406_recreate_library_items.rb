class RecreateLibraryItems < ActiveRecord::Migration[8.0]
  def change
    create_table :library_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.string :status
      t.integer :rating
      t.text :notes

      t.timestamps
    end

    add_index :library_items, [:user_id, :game_id], unique: true
  end
end

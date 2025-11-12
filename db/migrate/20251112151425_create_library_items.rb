class CreateLibraryItems < ActiveRecord::Migration[8.0]
  def change
    create_table :library_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

class DropLibraryItemsTable < ActiveRecord::Migration[8.0]
  def change
        drop_table :library_items, if_exists: true
  end
end

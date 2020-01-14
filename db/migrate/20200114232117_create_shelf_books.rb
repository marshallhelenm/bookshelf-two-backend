class CreateShelfBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :shelf_books do |t|
      t.integer :shelf_id
      t.integer :book_id

      t.timestamps
    end
  end
end

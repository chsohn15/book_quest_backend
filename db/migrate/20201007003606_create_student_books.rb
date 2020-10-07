class CreateStudentBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :student_books do |t|
      t.integer :student_id
      t.integer :book_id
      t.boolean :currently_reading
      t.integer :total_pages

      t.timestamps
    end
  end
end

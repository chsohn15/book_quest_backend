class AddColumnCurrentPageToStudentBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :student_books, :current_page, :integer, default: 0
  end
end

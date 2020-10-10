class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :student_books, :character_id, :integer
  end
end

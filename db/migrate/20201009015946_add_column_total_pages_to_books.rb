class AddColumnTotalPagesToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :total_pages, :integer
  end
end

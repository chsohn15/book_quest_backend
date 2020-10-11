class ChangeColumnTypeInBooks < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :ISBN_number, :string
  end
end

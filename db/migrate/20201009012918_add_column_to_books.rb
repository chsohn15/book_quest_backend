class AddColumnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :image_url, :string
  end
end

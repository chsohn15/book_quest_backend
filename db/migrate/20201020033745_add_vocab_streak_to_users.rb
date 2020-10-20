class AddVocabStreakToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :vocab_streak, :integer, default: 0
  end
end

class AddColumnToReadingTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :reading_tweets, :character_id, :integer
  end
end

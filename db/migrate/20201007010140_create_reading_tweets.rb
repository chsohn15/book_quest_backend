class CreateReadingTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :reading_tweets do |t|
      t.integer :student_book_id
      t.text :submission
      t.integer :point_value
      t.string :difficulty_level

      t.timestamps
    end
  end
end

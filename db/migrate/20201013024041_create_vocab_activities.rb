class CreateVocabActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :vocab_activities do |t|
      t.integer :student_book_id
      t.string :word
      t.text :definition
      t.text :sentence_from_book
      t.text :original_sentence
      t.text :original_sentence_2
      t.text :analysis

      t.timestamps
    end
  end
end

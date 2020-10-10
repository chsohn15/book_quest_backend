class Character < ApplicationRecord
    belongs_to :book, optional: true
    has_many :student_books
    has_many :reading_tweets
end

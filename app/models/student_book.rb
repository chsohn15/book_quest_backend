class StudentBook < ApplicationRecord
    belongs_to :student, foreign_key: "student_id", class_name: "User"
    belongs_to :book
    has_many :reading_tweets
end

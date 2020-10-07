class Book < ApplicationRecord
    has_many :student_books
    has_many :students, class_name: "User", foreign_key: "student_id", through: :student_books
end

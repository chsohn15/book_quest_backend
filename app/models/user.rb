class User < ApplicationRecord
    has_many :students, class_name: "User", foreign_key: "teacher_id"
    belongs_to :teacher, class_name: "User", optional: true

    has_many :student_books, foreign_key: "student_id"
    has_many :books, through: :student_books

    has_secure_password

    def validate_book(new_book)
        if self.books.include?(new_book)
            return false 
        else    
            self.books << new_book 
            return true
        end
    end
end

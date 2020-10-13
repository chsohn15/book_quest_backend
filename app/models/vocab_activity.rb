class VocabActivity < ApplicationRecord
    belongs_to :student_book, optional: true
end

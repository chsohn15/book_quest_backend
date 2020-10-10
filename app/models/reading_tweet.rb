class ReadingTweet < ApplicationRecord
    belongs_to :student_book, optional: true
    belongs_to :character, optional: true

end

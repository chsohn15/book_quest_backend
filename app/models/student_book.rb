class StudentBook < ApplicationRecord
    belongs_to :student, foreign_key: "student_id", class_name: "User"
    belongs_to :book
    belongs_to :character, optional: true
    has_many :reading_tweets

    def twitter_character 
        if self.character_id 
            id = self.character_id
            character = Character.find(id)
            return character 
        end
    end
end

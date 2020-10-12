class StudentBook < ApplicationRecord
    belongs_to :student, foreign_key: "student_id", class_name: "User"
    belongs_to :book
    belongs_to :character, optional: true
    has_many :reading_tweets

    def twitter_character 
        # If character exists, set as 'twitter character'
        if self.character_id 
            id = self.character_id
            character = Character.find(id)
            return character 
        end
    end

    def total_tweet_points 
        sum = self.reading_tweets.sum do |tweet| 
            tweet.point_value 
        end
        sum
    end

    def most_recent_tweet 
        self.reading_tweets.last
    end

    def second_most_recent_tweet
        self.reading_tweets[-2]
    end


end

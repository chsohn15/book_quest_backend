class Api::V1::ReadingTweetsController < ApplicationController

    def index 
        reading_tweets = ReadingTweet.all 
        render json: reading_tweets, include: [:character, :student_book]
    end

    def add_tweet 
        reading_tweet = ReadingTweet.new(tweet_params)
        byebug

    end

    private 

    def tweet_params 
        params.permit(:submission, :point_value, :student_book_id, :character_id)
    end
    
end

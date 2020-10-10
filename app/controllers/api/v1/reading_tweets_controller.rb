class Api::V1::ReadingTweetsController < ApplicationController

    def index 
        reading_tweets = ReadingTweet.all 
        render json: reading_tweets, include: :character
    end
    
end

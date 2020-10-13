class Api::V1::ReadingTweetsController < ApplicationController

    def index 
        reading_tweets = ReadingTweet.all 
        render json: reading_tweets, include: [:character, :student_book]
    end

    def add_tweet 
        reading_tweet = ReadingTweet.new(tweet_params)
        reading_tweet.save

        student_book = StudentBook.find_by(id: params[:student_book_id])

        render json: student_book, include: [:reading_tweets =>{include: [:character]}, :book => {include: [:characters]}], methods: :twitter_character

    end

    def destroy 
        reading_tweet = ReadingTweet.find_by(id: params[:id])
        reading_tweet.destroy 

        render json: {message: "You've deleted this tweet!"}
    end

    private 

    def tweet_params 
        params.permit(:submission, :point_value, :student_book_id, :character_id)
    end
    
end

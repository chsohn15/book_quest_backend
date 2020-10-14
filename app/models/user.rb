require 'date'

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

    def current_book
        found_book = self.student_books.find do |book|
            book.currently_reading == true 
        end
        found_book
    end

    def bookshelf 
        bookshelf = self.student_books.select do |book|
            book.currently_reading == false 
        end
        final_bookshelf = bookshelf.map do |student_book|
            student_book.book
        end
        return final_bookshelf
    end

    def total_points 
        total_points = self.student_books.sum {|student_book| student_book.total_tweet_points}
        return total_points
    end

    # Array of most recent tweet in each student book
    def last_tweet_array
        arr = []
        self.student_books.each do |student_book|
            if student_book.reading_tweets.length > 0 
                arr << student_book.most_recent_tweet 
                arr << student_book.second_most_recent_tweet
            end
        end
        return arr
    end

    # Get date of last tweet
    def last_tweet_date
        arr = self.last_tweet_array.sort { |a,b| a.created_at <=> b.created_at }
        return arr[-2].created_at
    end

    def all_tweets
        arr = []
        self.student_books.each do |student_book|
            if student_book.reading_tweets.length > 0 
                student_book.reading_tweets.each do |reading_tweet|
                    arr << reading_tweet 
                end
            end
        end
        return arr
    end


    def first_tweet_date 
        arr = []
        self.student_books.each do |student_book|
            if student_book.reading_tweets.length > 0 
                arr << student_book.first_tweet
            end
        end
        arr = self.last_tweet_array.sort { |a,b| a.created_at <=> b.created_at }
        return Time.at(arr[0].created_at).to_date
    end

    def tweet_dates_array
        arr = (self.first_tweet_date..Date.today.to_date).map do |date|
            {date: date, tweet_count: 0}
        end
        return arr
    end

    def tweet_hash
        # self.tweet_dates_array = [{:date=>Sat, 10 Oct 2020, :tweet_count=>0}, {:date=>Sun, 11 Oct 2020, :tweet_count=>0}]
        # self.all_tweets = array of tweet objects
        final_array = self.tweet_dates_array

        # Iterate through all tweets 
        # If found in tweet dates array, increment tweet_count by one
        self.all_tweets.each do |tweet|
            found_hash = final_array.find{ |tweet_hash| tweet_hash[:date] == Time.at(tweet.created_at).to_date}
            found_hash[:tweet_count] += 1
        end
        return final_array 
    end

    def all_vocab
        arr = []
        self.student_books.each do |student_book|
            if student_book.vocab_activities.length > 0 
                student_book.vocab_activities.each do |vocab_activity|
                    hash = {}
                    hash[:vocab] = vocab_activity
                    hash[:book_title] = vocab_activity.student_book.book.title
                    arr << hash
                end
            end
        end
        return arr
    end

end


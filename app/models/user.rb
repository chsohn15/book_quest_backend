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

    # array of tweet dates, no duplicates
    def tweet_hash
        arr = []
        # Iterate through user tweet objects, i.e. 'all_tweets'
        # If there are no tweets, add the tweet date creation to array
        # If the array already contains data, check to see if tweet's created_at time already exists in array
        # If it doesn't exist yet, then add it to the array
        self.all_tweets.each do |tweet|
            if arr.length == 0
                arr << {date: tweet.created_at.to_date}
            elsif arr.length > 0 
                if !arr.include?({"date": Time.at(tweet.created_at).to_date})
                        arr << {date: tweet.created_at.to_date}
                end
            end
        end
        return arr
    end


end


class Api::V1::UsersController < ApplicationController
    skip_before_action :logged_in?, only: [:create]
    
    def index 
        users = User.all 
        render json: users, only: [:id, :first_name, :last_name, :username, :is_student, :character_id, :streak], include: [:books, :student_books], methods: [:current_book, :total_points]
    end

    def show 
        user = User.find_by(id: params[:id])

        user.streak = self.load_streak(user.id)

        render json: user, only: [:id, :first_name, :last_name, :username, :is_student, :character_id, :streak], include: [:books, :student_books], methods: [:total_points, :current_book, :bookshelf]
    end

    def create 
        user = User.new(user_params)
        if user.valid? 
            user.save 
            render json: {
                id: user.id,
                first_name: user.first_name,
                last_name: user.last_name,
                is_student: user.is_student,
                username: user.username, 
                token: encode_token({user_id: user.id})}, status: :created 
        else   
            render json: {error: "Failed to create user"}, status: :not_acceptable 
        end 
    end

    def change_character
        user = User.find_by(id: params[:id])

        user.character_id = nil
        user.twitter_character = nil
        user.save 

        render json: user, only: [:id, :first_name, :last_name, :username, :is_student, :character_id], include: [:books, :student_books], methods: [:total_points, :current_book, :bookshelf]
    end

    # def handle_streak 
    #     user = User.find_by(id: params[:id])

    #     # If user has no tweets yet, set streak to 1
    #     if user.last_tweet_array.length == 0
    #         byebug
    #         user.streak = 1 
    #     else 
    #         date = user.last_tweet_date.to_date
    #         if date == Date.yesterday
    #             byebug
    #             user.streak += 1
    #         elsif user.last_tweet_date.today? 
    #             byebug
    #             user.streak = user.streak
    #          else 
    #             byebug
    #             user.streak = 0 
    #         end
    #     end
        
    #     user.save
    #     render json: user, only: [:streak]
    # end

    # loadStreak method 
    def load_streak(id)
        user = User.find(id)

        tweet_hash_array = user.tweet_hash
        if user.all_tweets.length > 0 
            # If tweet hash encompasses more than two days, find if there were any tweets yesterday
            if tweet_hash_array.length > 0 && tweet_hash_array.any?{ |tweet_hash| tweet_hash[:date] == Date.yesterday}
                yesterday_hash = tweet_hash_array.find{ |tweet_hash| tweet_hash[:date] == Date.yesterday}
                today_hash = tweet_hash_array.find{ |tweet_hash| tweet_hash[:date] == Date.today}
                if yesterday_hash[:tweet_count] == 0 
                    user.streak = 0 
                    if today_hash[:tweet_count] > 0
                        user.streak += 1 
                    end 
                end 
            elsif tweet_hash_array.length > 0 && !tweet_hash_array.any?{ |tweet_hash| tweet_hash[:date] == Date.yesterday}
                user.streak = 0 
                    if tweet_hash_array.any?{ |tweet_hash| tweet_hash[:date] == Date.today && tweet_hash[tweet_count] > 0}
                        user.streak += 1 
                    end 
            elsif tweet_hash_array.length == 0
                user.streak = 0 
            end 
        end
        calc_streak = user.streak
        return calc_streak
            
    end

    def get_tweet_data
        user = User.find_by(id: params[:id])
        tweet_data = user.tweet_hash

        render json: tweet_data
    end

    private 

    def user_params 
        params.permit(:username, :password, :first_name, :last_name)
    end

end

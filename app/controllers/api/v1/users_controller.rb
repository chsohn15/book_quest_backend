class Api::V1::UsersController < ApplicationController
    skip_before_action :logged_in?, only: [:create]
    
    def index 
        users = User.all 
        render json: users, only: [:id, :first_name, :last_name, :username, :is_student, :character_id, :streak], include: [:books, :student_books], methods: [:current_book, :total_points, :all_vocab]
    end

    def show 
        user = User.find_by(id: params[:id])

        user.streak = self.load_streak(user.id)

        render json: user, only: [:id, :first_name, :last_name, :username, :is_student, :character_id, :streak], include: [:books, :student_books], methods: [:total_points, :current_book, :bookshelf, :all_vocab]
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

    def load_streak(id)
        user = User.find(id)

        hash_count = {today: 0, yesterday: 0}

       user.all_tweets.each do |tweet_hash| 
            if tweet_hash[:created_at].to_date == Date.yesterday 
                hash_count[:yesterday] += 1 
            elsif tweet_hash[:created_at].to_date == Date.today 
                hash_count[:today] += 1 
            end 
        end

        if user.all_tweets.length > 0 
            if hash_count[:yesterday] == 0 
                #byebug
                user.streak = 0 
                if hash_count[:today] >= 1
                    user.streak = 1 
                end 
            elsif hash_count[:yesterday] > 0 && hash_count[:today] == 1
                #byebug
                user.streak += 1 
            end 
        elsif user.all_tweets.length ==0 
            user.streak = 0 
        end

        calc_streak = user.streak
        return calc_streak

    end


    def get_tweet_data
        user = User.find_by(id: params[:id])
        tweet_data = user.tweet_hash

        render json: tweet_data
    end

    def get_vocab 

    end

    private 

    def user_params 
        params.permit(:username, :password, :first_name, :last_name)
    end

end

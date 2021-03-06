class Api::V1::UsersController < ApplicationController
    skip_before_action :logged_in?, only: [:create]
    
    def index 
        users = User.all 
        render json: users, only: [:id, :first_name, :last_name, :username, :is_student, :character_id, :streak, :vocab_streak, :image_url], include: [:books, :student_books], methods: [:current_book, :total_points, :all_vocab, :rewards_hash, :money_spent, :balance, :all_tweets]
    end

    def show 
        user = User.find_by(id: params[:id])

        user.streak = self.load_streak(user.id)
        user.vocab_streak = self.load_vocab_streak(user.id)
        
        render json: user, only: [:id, :first_name, :last_name, :username, :is_student, :character_id, :streak, :vocab_streak, :image_url], include: [:books, :student_books], methods: [:total_points, :current_book, :bookshelf, :all_vocab, :rewards_hash, :money_spent, :balance, :all_tweets]
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

    def update 
        user = User.find_by(id: params[:id])

        user.update(image_url: params[:image_url])

        render json: user
    end

    def change_character
        user = User.find_by(id: params[:id])

        user.character_id = nil
        user.twitter_character = nil
        user.save 

        render json: user, only: [:id, :first_name, :last_name, :username, :is_student, :character_id], include: [:books, :student_books], methods: [:total_points, :current_book, :bookshelf]
    end

    # def load_streak(id)
    #     user = User.find(id)

    #     hash_count = {today: 0, yesterday: 0}

    #    user.all_tweets.each do |tweet_hash| 
    #         if tweet_hash[:created_at].to_date == Date.yesterday
    #             hash_count[:yesterday] += 1 

    #         elsif tweet_hash[:created_at].to_date == Date.today 
    #             hash_count[:today] += 1 
    #         end 
    #     end
    #     if user.all_tweets.length > 0 
    #         if hash_count[:yesterday] == 0 
    #             user.streak = 0 
    #             if hash_count[:today] >= 1

    #                 user.streak = 1 
    #             end 
    #         elsif hash_count[:yesterday] > 0 && hash_count[:today] == 1
    #             streak_yesterday = user.streak
    #             byebug
    #             user.streak = streak_yesterday + 1 
    #         elsif hash_count[:yesterday] >=1 && hash_count[:today] == 0
    #             byebug
    #             user.streak = 1 
    #         elsif hash_count[:yesterday] >=1 && hash_count[:today] >= 1
    #             byebug
    #             user.streak = 2
    #         end 
    #     elsif user.all_tweets.length ==0 
    #         user.streak = 0 
    #     end

    #     calc_streak = user.streak
    #     return calc_streak

    # end

    def load_streak(id)
        user = User.find(id)

        #user.tweet_hash = 
        #[{:date=>Sat, 10 Oct 2020, :tweet_count=>5}, 
        #{:date=>Sun, 11 Oct 2020, :tweet_count=>5}, 
        #{:date=>Mon, 12 Oct 2020, :tweet_count=>0}, 
        #{:date=>Tue, 13 Oct 2020, :tweet_count=>1}, 
        #{:date=>Wed, 14 Oct 2020, :tweet_count=>1}, 
        #{:date=>Thu, 15 Oct 2020, :tweet_count=>0}]

        # TODO: If all counts are greater than 0, then streak = length of array 
        if user.tweet_hash == []
            user.streak = 0
            #byebug
            # Find the most recent date with no tweets (not today)
        else
           
            
                no_tweets_date = user.tweet_hash.reverse.find do |tweet_hash|
                    tweet_hash[:tweet_count] == 0 && tweet_hash[:date] != Date.today
                end

                tweeted_today_bool = user.tweet_hash.any? { |tweet_hash| tweet_hash[:date] == Date.today && tweet_hash[:tweet_count] > 0}
                
                # If there are no previous tweet dates but they tweeted today, set streak to 1
                if no_tweets_date == nil && tweeted_today_bool 
                    user.streak = user.tweet_hash.size
                elsif no_tweets_date == nil && tweeted_today_bool == false
                        user.streak = 0
                # If there were no tweets yesterday, set streak to 0
                elsif no_tweets_date[:date] == Date.yesterday
                    user.streak = 0 

                #If there were no tweets yesterday, and one today, user streak is 1
                #maybe make another start another if conditional here
                    if no_tweets_date[:date] == Date.yesterday && user.tweet_hash.last[:tweet_count] >= 1
                    user.streak = 1
                    end

                # If today's count is 0, calculate total streak from yesterday
                elsif user.tweet_hash.last[:tweet_count] == 0 
                    temp_streak = Date.yesterday - no_tweets_date[:date]
                    user.streak = temp_streak.to_s[0].to_i 

                else
                    # Else calculate streak from today
                    temp_streak = Date.today - no_tweets_date[:date]
                    user.streak = temp_streak.to_s[0].to_i 
                end
        end
    end

    def load_vocab_streak(id)
        user = User.find(id)


        # TODO: If all counts are greater than 0, then streak = length of array 
        if user.vocab_hash == []
            user.vocab_streak = 0
            
            # Find the most recent date with no tweets (not today)
            else
            
                no_vocab_date = user.vocab_hash.reverse.find do |vocab_hash|
                    vocab_hash[:vocab_count] == 0 && vocab_hash[:date] != Date.today
                end

                vocab_today_bool = user.vocab_hash.any? { |vocab_hash| vocab_hash[:date] == Date.today && vocab_hash[:vocab_count] > 0}

                # If there are no previous tweet dates but they tweeted today, set streak to 1
                if no_vocab_date == nil && vocab_today_bool 
                    user.streak = user.vocab_hash.size
                    
                elsif no_vocab_date == nil && vocab_today_bool == false
                    user.vocab_streak = 0
                # If there were no tweets yesterday, set streak to 0
                elsif no_vocab_date[:date] == Date.yesterday
                    user.vocab_streak = 0 

                #If there were no tweets yesterday, and one today, user streak is 1
                #maybe make another start another if conditional here
                    if no_vocab_date[:date] == Date.yesterday && user.vocab_hash.last[:vocab_count] >= 1
                    user.vocab_streak = 1
                    end

                # If today's count is 0, calculate total streak from yesterday
                elsif user.vocab_hash.last[:vocab_count] == 0 
                    temp_streak = Date.yesterday - no_vocab_date[:date]
                    user.vocab_streak = temp_streak.to_s[0].to_i 

                else
                    # Else calculate streak from today
                    temp_streak = Date.today - no_vocab_date[:date]
                    user.vocab_streak = temp_streak.to_s[0].to_i 
                end
        end
    end

    # Fetch tweet data for graph
    def get_tweet_data
        user = User.find_by(id: params[:id])
        tweet_data = user.tweet_hash

        render json: tweet_data
    end

    # Fetch all of the user's tweets for all tweets page
    def get_all_tweets 
        user = User.find_by(id: params[:id])
        all_tweets = user.all_tweets

        render json: all_tweets, include: [:character, :student_book => {include: [:book => {only: [:title]}]}]
    end

    def get_vocab_data
        user = User.find_by(id: params[:id])
        
        vocab_data = user.vocab_hash

        render json: vocab_data
    end



    private 

    def user_params 
        params.permit(:username, :password, :first_name, :last_name)
    end

end

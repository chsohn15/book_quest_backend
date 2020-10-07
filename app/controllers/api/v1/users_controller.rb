class Api::V1::UsersController < ApplicationController

    def index 
        users = User.all 
        render json: users, only: [:id, :first_name, :last_name, :username, :is_student]
    end

    def create 
        user = User.new(user_params)
        if user.valid? 
            user.save 
            render json: {user: user}, status: :created 
        else   
            render json: {error: "Failed to create user"}, status: :not_acceptable 
        end 
    end

    private 

    def user_params 
        params.permit(:username, :password, :first_name, :last_name)
    end

end

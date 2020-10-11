class Api::V1::AuthController < ApplicationController
    skip_before_action :logged_in?, only: [:create]

    def create 
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            render json: {
                id: user.id,
                first_name: user.first_name,
                last_name: user.last_name,
                is_student: user.is_student,
                username: user.username, 
                total_points: user.total_points,
                token: encode_token({user_id: user.id})}, status: 200 
        else        
            render json: {error: "Invalid username and password"}
        end 
    end 
end

class ApplicationController < ActionController::API
    before_action :logged_in?, except: [:index, :show]

    def encode_token(payload)
        JWT.encode(payload, "copperfield")
    end 

    def logged_in?
        headers = request.headers["Authorization"]
        return render json: {error: "Please login"} unless headers
        
        token = headers.split(" ")[1]
        
        begin
          user_id = JWT.decode(token, "copperfield")[0]["user_id"]
          user = User.find(user_id)
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          user = nil
        end
        
        render json: {error: "Please login"} unless user
    end
end

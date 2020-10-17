class Api::V1::RewardTiersController < ApplicationController

    def index 
        reward_tiers = RewardTier.all

        render json: reward_tiers
    end

end

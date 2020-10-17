class Api::V1::RewardsController < ApplicationController

    def index 
        rewards = Reward.all

        render json: rewards
    end

    def show
        reward = Reward.find_by(id: params[:id])

        render json: reward 
    end

    def create 
        reward_tier_id = RewardTier.find_by(level: params[:level]).id

        reward = Reward.create(
            price: params[:price], 
            student_id: params[:student_id], 
            description: params[:description], 
            reward_tier_id: reward_tier_id,
            redeemed: true)

        render json: reward

    end


end
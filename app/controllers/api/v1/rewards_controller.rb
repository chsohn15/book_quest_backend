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

        user = User.find_by(id: params[:student_id])

        description = params[:description]

        price = params[:price]
        if reward_tier_id == 2 && user.tier_one_complete == false 
            render json: {errors: "You need to redeem Level 1 rewards first!"}
        elsif reward_tier_id == 3 && user.tier_two_complete == false 
            render json: {errors: "You need to redeem Level 2 rewards first!"}
        elsif user.rewards_hash[description]
            render json: {errors: "You've already redeemed this reward!"}
        elsif price > user.balance
            render json: {errors: "You need to earn more stars to redeem this reward!"}
        else
            reward = Reward.create(
                price: params[:price], 
                student_id: params[:student_id], 
                description: params[:description], 
                reward_tier_id: reward_tier_id,
                redeemed: true)

            render json: reward
        end
    end


end

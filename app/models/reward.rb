class Reward < ApplicationRecord
    belongs_to :reward_tier, optional: true
end

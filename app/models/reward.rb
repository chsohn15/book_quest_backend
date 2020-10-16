class Reward < ApplicationRecord
    belongs_to :reward_tier, optional: true
    belongs_to :student, foreign_key: "student_id", class_name: "User", optional: true
end

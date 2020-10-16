class RewardTier < ApplicationRecord
    has_many :rewards
    has_many :students, foreign_key: "student_id", class_name: "User", through: :rewards
end

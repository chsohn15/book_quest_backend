class RewardTier < ApplicationRecord
    belongs_to :student, foreign_key: "student_id", class_name: "User"
    has_many :rewards
end

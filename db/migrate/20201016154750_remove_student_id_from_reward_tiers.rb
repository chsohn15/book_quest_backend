class RemoveStudentIdFromRewardTiers < ActiveRecord::Migration[6.0]
  def change
    remove_column :reward_tiers, :student_id
  end
end

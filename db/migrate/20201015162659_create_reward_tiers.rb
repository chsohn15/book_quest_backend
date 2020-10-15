class CreateRewardTiers < ActiveRecord::Migration[6.0]
  def change
    create_table :reward_tiers do |t|
      t.integer :level
      t.integer :student_id

      t.timestamps
    end
  end
end

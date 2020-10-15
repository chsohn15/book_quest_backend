class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.boolean :redeemed
      t.integer :price
      t.text :description
      t.integer :reward_tier_id

      t.timestamps
    end
  end
end

class AddColumnToVocabActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :vocab_activities, :point_value, :integer
  end
end

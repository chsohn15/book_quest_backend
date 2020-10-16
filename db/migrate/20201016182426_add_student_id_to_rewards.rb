class AddStudentIdToRewards < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards, :student_id, :integer
  end
end

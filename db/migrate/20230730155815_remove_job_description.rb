class RemoveJobDescription < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :job_description, :text
  end
end

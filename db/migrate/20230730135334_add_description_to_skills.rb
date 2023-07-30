class AddDescriptionToSkills < ActiveRecord::Migration[7.0]
  def change
    add_column :skills, :description, :text
  end
end

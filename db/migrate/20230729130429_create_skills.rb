class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :technology
      t.string :level

      t.timestamps
    end
  end
end

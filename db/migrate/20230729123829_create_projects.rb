class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :amount_of_people
      t.string :repo_link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

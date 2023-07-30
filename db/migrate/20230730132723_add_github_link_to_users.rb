class AddGithubLinkToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :github_link, :string
  end
end

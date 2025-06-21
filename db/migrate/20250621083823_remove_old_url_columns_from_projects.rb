class RemoveOldUrlColumnsFromProjects < ActiveRecord::Migration[8.0]
  def change
    remove_column :projects, :github_url, :string
    remove_column :projects, :youtube_url, :string
    remove_column :projects, :demo_url, :string
  end
end

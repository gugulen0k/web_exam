class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description
      t.text :detailed_description
      t.string :author_name, null: false
      t.string :github_url
      t.string :youtube_url
      t.string :demo_url
      t.string :technology_stack
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

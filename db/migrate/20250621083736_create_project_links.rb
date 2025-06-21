class CreateProjectLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :project_links do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url, null: false
      t.string :link_type, default: 'custom'
      t.string :icon
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :project_links, [ :project_id, :position ]
  end
end

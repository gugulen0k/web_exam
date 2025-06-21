class CreateProjectImages < ActiveRecord::Migration[8.0]
  def change
    create_table :project_images do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :position, default: 0

      t.timestamps
    end
  end
end

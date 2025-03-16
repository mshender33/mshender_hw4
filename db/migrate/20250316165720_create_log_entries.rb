class CreateLogEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :log_entries do |t|
      t.string :title
      t.text :description
      t.date :occurred_on
      t.references :user, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :start
      t.datetime :end
      t.integer :priority
      t.integer :status

      t.timestamps
    end
  end
end

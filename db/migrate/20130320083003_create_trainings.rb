class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.datetime :start
      t.string :comment

      t.timestamps
    end
  end
end

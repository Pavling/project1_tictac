class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :result
      t.integer :value
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end

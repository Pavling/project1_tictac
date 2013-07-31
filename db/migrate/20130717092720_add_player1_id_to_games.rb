class AddPlayer1IdToGames < ActiveRecord::Migration
  def change
    add_column :games, :player1_id, :integer
  end
end

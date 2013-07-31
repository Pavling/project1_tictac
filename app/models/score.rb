class Score < ActiveRecord::Base
  attr_accessible :game_id, :result, :user_id, :value
  belongs_to :user
  belongs_to :game
end

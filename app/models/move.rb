class Move < ActiveRecord::Base
  belongs_to :player, class_name: 'User'
  belongs_to :game
  attr_accessible :square, :symbol, :player_id

  after_create :check_if_game_is_won


def check_if_game_is_won
  game.check_if_won!
end

end

class Game < ActiveRecord::Base
  attr_accessible :name, :player1_id
  has_many :scores
  has_many :moves
  belongs_to :player1, class_name: 'User'

  def winning_lines
  [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]
  end

  def winning_game?
    winning_lines.detect do |winning_line|
      line_scores = winning_line.map{|e| moves_made_array[e]}
      line_scores.any? && line_scores.uniq.size == 1
    end
  end

  def moves_made_array
    a = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
    moves.each do| move|
      a[move.square] = move.symbol
    end
    return a
  end

  def player2
    # Put in multiplayer here, this should return the second player or the computer
    :computer
  end

  def make_move(player, square)
    player_id = (player.id if player.respond_to?(:id))
    raise "you're not my player" unless [player1.id, nil].include?(player_id)
    raise "it's not your turn" unless whose_turn == player
    raise "square is taken" if moves_made_array[square]
    raise "game is finished" if game_finished?
    moves.create! player_id: player_id, square: square, symbol: which_symbol
  end

  def make_computer_move!
    square = moves_made_array.each_with_index.map { |e,i| i unless e }.compact.sample
    make_move :computer, square
  end

  def whose_turn
    return player1 if moves.empty?
    moves.last.player == player1 ? player2 : player1
  end

  def which_symbol
    return 'X' if moves.empty?
    moves.last.symbol == 'X' ? 'O' : 'X'
  end

  def game_finished?
    winning_game? || moves_made_array.all?
  end

  def check_if_won!
    raise "already scored" if scores.any?
    if game_finished?
      if winning_game?
        winner = moves.last.player
        if winner
          winner.scores.create! result: :win, value: 10, game_id: self.id
        else
          player1.scores.create! result: :lose, value:0, game_id: self.id
        end
      else
        player1.scores.create! result: :draw, value: 5, game_id: self.id
      end
    end
  end
end



# def which_players_turn
#    return player1 if moves.empty?
#    moves.last.player == player1 ? player2 : player1
# end



# def self.create_for_players(game_player1, game_player2)
#   game = Game.create
#   [game_player1, game_player2].shuffle.each_with_index do |game_player, index|
#   Score.create user_id: game_player.id, game_id: game.id, player_position: (index + 1)
#     end
# end
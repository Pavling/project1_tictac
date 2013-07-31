class GamesController < ApplicationController

  def new
    redirect_to(root_path) and return unless current_user
    @game = Game.create player1_id: current_user.id
    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
    #rescue from game is finished and redirect to user show with a message
  end

  def make_move
    @game = Game.find(params[:id])
    @game.make_move current_user, params[:square].to_i
    @game.make_computer_move! unless @game.game_finished?
    flash[:notice] = "Game is finished!" if @game.game_finished?
     if @game.game_finished?
     flash[:notice] = "GAME OVER MAN!!!!"
      # redirect_to games_path and return
    end
    render :show
  end

 def index
    @games = Game.all
  end


end

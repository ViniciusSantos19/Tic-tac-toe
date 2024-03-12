require_relative 'player'
require_relative 'tic_tac_toe'

jogador1 = Player.new('vini', 'X')
jogador2 = Player.new('Maya', 'O')

jogo = TicTacToe.new([jogador1, jogador2])
jogo.start_game

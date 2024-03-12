require_relative 'player'
class TicTacToe
  attr_accessor :matriz, :status_partida

  def initialize(players)
    @matriz = [['', '', ''], ['', '', ''], ['', '', '']]
    @status_partida = true
    @players = players
    @current_player = @players[0]
  end

  def display_board
    puts "  #{@matriz[0][0]} | #{@matriz[0][1]} | #{@matriz[0][2]}"
    puts ' ---+---+---'
    puts "  #{@matriz[1][0]} | #{@matriz[1][1]} | #{@matriz[1][2]}"
    puts ' ---+---+---'
    puts "  #{@matriz[2][0]} | #{@matriz[2][1]} | #{@matriz[2][2]}"
  end

  def switch_player
    @current_player = @players[@players.index(@current_player).zero? ? 1 : 0]
  end

  def get_player_move(player)
    loop do
      puts "#{player.name}´s turn. Enter a row (1-3) and column (1-3):"
      move = gets.chomp.split(' ').map(&:to_i)
      row, col = move
      return [row - 1, col - 1] if row.between?(1, 3) && col.between?(1, 3) && @matriz[row - 1][col - 1] == ''

      puts 'Invalid move. Please enter a valid row and column.'
    end
  end

  def make_move(row, col)
    @matriz[row][col] = @current_player.player_mark
  end

  def rows_have_same_characters?
    puts 'row validate'
    @matriz.any? do |row|
      row.uniq.size == 1 && %w[X O].include?(row.first)
    end
  end

  def columns_have_same_characters?
    puts 'column validate'
    @matriz.transpose.any? do |column|
      column.uniq.size ==  1 && %w[X O].include?(column.first)
    end
  end

  def check_winner
    return "#{@current_player.name} won" if rows_have_same_characters?
    return "#{@current_player.name} won" if columns_have_same_characters?

    # check diagonals
    return "#{@current_player.name} won" if [@matriz[0][0], @matriz[1][1], @matriz[2][2]].all? do |cell|
                                              cell.casecmp('X').zero?
                                            end
    return "#{@current_player.name} won" if [@matriz[0][2], @matriz[1][1], @matriz[2][0]].all? do |cell|
                                              cell.casecmp('X').zero?
                                            end
    return "#{@current_player.name} won" if [@matriz[0][0], @matriz[1][1], @matriz[2][2]].all? do |cell|
                                              cell.casecmp('O').zero?
                                            end
    return "#{@current_player.name} won" if [@matriz[0][2], @matriz[1][1], @matriz[2][0]].all? do |cell|
                                              cell.casecmp('O').zero?
                                            end

    return 'Tie' if @matriz.flatten.all? { |a| a != '' }

    nil
  end

  def start_game
    while status_partida
      display_board
      row, col = get_player_move(@current_player)
      make_move(row, col)
      winner = check_winner
      if winner
        @status_partida = false
        puts winner
        display_board
      else
        switch_player
      end
    end
  end
end

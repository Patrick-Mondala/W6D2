require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    children = TicTacToeNode.new(game.board, mark).children
    winning = children.select {|kid| kid.winning_node?(mark) && !kid.losing_node?(mark)}
    return winning.first.prev_move_pos unless winning.empty? || winning.none? { |kid| kid.children.any? {|kid2| kid2.board.won?}}

    non_losing = children.reject {|kid| kid.losing_node?(mark)}
    return non_losing.first.prev_move_pos unless non_losing.empty?

    raise "No non-losing move"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

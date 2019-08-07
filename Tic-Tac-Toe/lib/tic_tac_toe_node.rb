require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos, :current_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @current_mark = @next_mover_mark == :x ? :o : :x
  end

  def losing_node?(evaluator)
    if @board.over?
      return @board.won? && @board.winner != evaluator
    end

    if next_mover_mark == evaluator
      children.all? {|kid| kid.losing_node?(evaluator)}
    else
      children.any? {|kid| kid.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.won? && @board.winner == evaluator
    end

    if next_mover_mark == evaluator
      children.any? {|kid| kid.winning_node?(evaluator)}
    else
      children.all? {|kid| kid.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    nodes = []
    (0..2).each do |row_idx|
      (0..2).each do |col_idx|
        if @board.empty?([row_idx, col_idx])
          duped_board = @board.dup
          duped_board[[row_idx, col_idx]] = next_mover_mark
          nodes << TicTacToeNode.new(duped_board, @current_mark, [row_idx, col_idx])
        end
      end
    end
    nodes
  end
end

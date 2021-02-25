class Fen

  attr_reader :board, :to_move, :castling, :en_passant, :half_moves, :full_moves

  def initialize(fen_string)
    string_fragments = split(fen_string)
    @board = string_fragments[:board]
    @to_move = string_fragments[:to_move]
    @castling = string_fragments[:castling]
    @en_passant = string_fragments[:en_passant]
    @half_moves = string_fragments[:half_moves]
    @full_moves = string_fragments[:full_moves]
  end

  def to_starting_position
    set_starting_board
    @board +  " w KQkq - 0 1"
  end

  private

  def set_starting_board
    default_board_wrapper = "rnbqkbnr/pppppppp/8/8/8/8/"
    default_white_string = "PPPPPPPP/RNBQKBNR"
    new_board = ""
    consecutive_numbers = 0
    default_white_string.split('').each do |char|
      result = @board.slice!(char)

      if result && consecutive_numbers == 0
        new_board += result
      elsif result
        new_board += consecutive_numbers.to_s + result
        consecutive_numbers = 0
      else
        consecutive_numbers += 1
      end

    end

    @board = default_board_wrapper + new_board
  end

  def split(fen_string)
    #example: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
    string_pieces = fen_string.split(" ")
  {
      board: string_pieces[0],
      to_move: string_pieces[1],
      castling: string_pieces[2],
      en_passant: string_pieces[3],
      half_moves: string_pieces[4],
      full_moves: string_pieces[5]
    }
  end
end

class Fen

  attr_reader :board, :to_move, :castling, :en_passant, :half_moves, :full_moves
  
  NON_WHITE_BOARD = "rnbqkbnr/pppppppp/8/8/8/8/"
  FULL_WHITE_BOARD = "PPPPPPPP/RNBQKBNR"

  def initialize(fen_string)
    string_fragments = split(fen_string)
    @board = string_fragments[:board]
    @to_move = string_fragments[:to_move]
    @castling = string_fragments[:castling]
    @en_passant = string_fragments[:en_passant]
    @half_moves = string_fragments[:half_moves]
    @full_moves = string_fragments[:full_moves]
  end


  def to_starting_position_string
    get_starting_board +  " w KQkq - 0 1"
  end

  private

  def get_starting_board
    current_board =  @board.reverse.reverse # this is to make your life easier
    NON_WHITE_BOARD + white_layout(current_board)
  end

  # def white_layout(current_board)
  #   new_board = ""
  #   consecutive_numbers = 0
  #   FULL_WHITE_BOARD.split('').each do |char|
  #     result = current_board.slice!(char)

  #     if result && consecutive_numbers == 0
  #       new_board += result
  #     elsif result
  #       new_board += consecutive_numbers.to_s + result
  #       consecutive_numbers = 0
  #     else
  #       consecutive_numbers += 1
  #     end
  #   end
  #   new_board
  # end

  def white_layout(current_board, white_default = FULL_WHITE_BOARD, number = nil, new_board = '')
    if white_default == ''
      new_board
    else
      char = white_default.slice!(white_default.first)
      result = current_board.slice!(char)
      if result
        white_layout(current_board, white_default, nil, new_board += number.to_s + result)
      else
        white_layout(current_board, white_default, number = number.to_i + 1, new_board)
      end
    end
  end

  def split(fen_string)
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

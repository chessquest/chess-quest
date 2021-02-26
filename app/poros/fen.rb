class Fen

  attr_reader :board, :to_move, :castling, :en_passant, :half_moves, :full_moves
  
  NON_WHITE_BOARD = "rnbqkbnr/pppppppp/8/8/8/8/"
  FULL_WHITE_BOARD = "PPPPPPPP/RNBQKBNR".split('')

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
    current_board =  @board[0..-1] # this is to make your life easier
    NON_WHITE_BOARD + white_layout(current_board)
  end

  def white_layout(current_board)
    empty_squares = nil
    FULL_WHITE_BOARD.map do |char|
      if piece = current_board.slice!(char)
        placement = empty_squares.to_s + piece
        empty_squares = nil
        placement
      else
        empty_squares = empty_squares.to_i + 1
        ''
      end
    end * '' + empty_squares.to_s
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

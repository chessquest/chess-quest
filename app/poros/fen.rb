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

  private

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

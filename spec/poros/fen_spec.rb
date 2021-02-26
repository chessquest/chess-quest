require "rails_helper"

describe Fen do
  before :each do
    @default_fen = Fen.new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
    @incomplete_fen = Fen.new("rnbqkbnr/pppppppp/8/8/8/8/PPP2PPP/R1BQKBNR b KQkq - 0 12")
  end

  describe "attributes" do
    it "exist" do
      expect(@default_fen.board).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
      expect(@default_fen.to_move).to eq("w")
      expect(@default_fen.castling).to eq("KQkq")
      expect(@default_fen.en_passant).to eq("-")
      expect(@default_fen.half_moves).to eq("0")
      expect(@default_fen.full_moves).to eq("1")
    end
  end

  describe "instance methods" do
    it "to_starting_position" do
      complete_board = Fen.new("r1b2b1r/p1p1p1pp/n3Pk1n/1p1p1p2/1PPP2P1/N4N1B/P2B1P1P/R1qQ1RK1 w - - 0 13")
      missing_knight = Fen.new("rnbqkbnr/ppppp3/5p2/7p/5p1P/8/PPPPPPP1/RNBQKBR1 w Qkq - 0 5")
      only_queen = Fen.new("rnbqkbnr/ppppp3/5p2/7p/5p1Q/8/8/5K2 w kq - 0 5")

      expect(@incomplete_fen.to_starting_position.fen).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKB1R w KQkq - 0 1")
      expect(complete_board.to_starting_position.fen).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      expect(missing_knight.to_starting_position.fen).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKB1R w KQkq - 0 1")
      expect(only_queen.to_starting_position.fen).to eq("rnbqkbnr/pppppppp/8/8/8/8/8/3QK3 w kq - 0 1")
    end
  end

  it "can reset a board from black pieces" do
    b_board = Fen.new("rnbqkbnr/pppppppp/8/8/8/8/PPP2PPP/R1BQKBNR b KQkq - 0 12", true)

    expect(b_board.to_starting_position.fen).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
  end
end

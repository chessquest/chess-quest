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
      expect(@incomplete_fen.to_starting_position).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKB1R w KQkq - 0 1")
    end
  end
end

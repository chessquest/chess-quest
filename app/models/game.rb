class Game < ApplicationRecord
  belongs_to :quest

  validates_presence_of :status
  validates_presence_of :starting_fen
  validates_presence_of :current_fen, on: :update

  enum status: [:in_progress, :won, :lost]
end

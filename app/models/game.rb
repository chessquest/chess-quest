class Game < ApplicationRecord
  belongs_to :quest

  validates_presence_of :status
  validates_presence_of :fen

  enum status: [:in_progress, :won, :lost]
end

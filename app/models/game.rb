class Game < ApplicationRecord
  after_initialize :default_fen
  belongs_to :quest

  validates_presence_of :status
  validates_presence_of :starting_fen
  validates_presence_of :current_fen, on: :update

  enum status: [:in_progress, :won, :lost]

  private

  def default_fen
    self.current_fen ||= self.starting_fen
  end
end

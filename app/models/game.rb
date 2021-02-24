class Game < ApplicationRecord
  belongs_to :quest

  validates_presence_of :status

  enum [:in_progress, :won, :lost]
end

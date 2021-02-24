class Game < ApplicationRecord
  belongs_to :quest

  validates_presence_of :status
end

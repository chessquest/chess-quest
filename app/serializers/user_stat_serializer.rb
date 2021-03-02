class UserStatSerializer
  include FastJsonapi::ObjectSerializer

  set_id {nil}

  has_many :games

  attribute :streak do |quest|
    quest.games.where(status: :won).count
  end

  attribute :quest_id do |quest|
    quest.id
  end
end

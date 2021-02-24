class CreateQuests < ActiveRecord::Migration[5.2]
  def change
    create_table :quests do |t|
      t.integer :status
      t.bigint :user_id

      t.timestamps
    end
  end
end

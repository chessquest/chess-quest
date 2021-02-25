class AddStartingFen < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.string :starting_fen
      t.string :current_fen
    end
    
    remove_column :games, :fen
  end
end

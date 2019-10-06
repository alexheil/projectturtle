class CreateLeagues < ActiveRecord::Migration[5.0]
  def change
    create_table :leagues do |t|
      t.references :game
      t.references :playlist
      t.string :title
      t.text :description
      t.string :image
      t.integer :number_of_participants, default: 2
      t.integer :number_of_weeks, default: 2
      t.integer :number_of_matches, default: 2
      t.string :slug

      t.timestamps
    end
  end
end

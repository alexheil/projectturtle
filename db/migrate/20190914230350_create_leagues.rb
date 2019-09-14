class CreateLeagues < ActiveRecord::Migration[5.0]
  def change
    create_table :leagues do |t|
      t.references :playlist
      t.string :title
      t.text :description
      t.string :image
      t.string :slug

      t.timestamps
    end
  end
end

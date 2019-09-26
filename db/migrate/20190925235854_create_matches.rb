class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.references :week
      t.references :participant
      t.integer :participant_one_id
      t.integer :participant_two_id
      t.string :title
      t.text :description
      t.string :image
      t.string :slug

      t.timestamps
    end

    add_index :matches, :participant_one_id
    add_index :matches, :participant_two_id
    add_index :matches, [:participant_one_id, :participant_two_id], unique: true
  end
end

class CreateMatchProofs < ActiveRecord::Migration[5.0]
  def change
    create_table :match_proofs do |t|
      t.references :match
      t.references :match_vote
      t.text :image_data
      t.text :description

      t.timestamps
    end
  end
end

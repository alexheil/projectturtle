class CreateMatchVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :match_votes do |t|
      t.references :user
      t.references :match
      t.references :participant
      t.text :image_data
      t.text :description

      t.timestamps
    end

    add_index :match_votes, [:user_id, :match_id], unique: true
  end
end

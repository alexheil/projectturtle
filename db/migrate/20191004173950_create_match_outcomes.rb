class CreateMatchOutcomes < ActiveRecord::Migration[5.0]
  def change
    create_table :match_outcomes do |t|
      t.references :participant
      t.references :match

      t.timestamps
    end

    add_index :match_outcomes, [:participant_id, :match_id], unique: true
  end
end

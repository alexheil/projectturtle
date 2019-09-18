class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :playlist
      t.references :video

      t.timestamps
    end
  end
end

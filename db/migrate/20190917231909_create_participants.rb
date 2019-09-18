class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :user
      t.references :league

      t.timestamps
    end
  end
end

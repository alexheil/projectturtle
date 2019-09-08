class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.references :user
      t.text :note
      t.string :image_data
      t.float :latitude
      t.float :longitude
      t.string :slug

      t.timestamps
    end
  end
end

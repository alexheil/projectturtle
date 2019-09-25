class CreateWeeks < ActiveRecord::Migration[5.0]
  def change
    create_table :weeks do |t|
      t.references :league
      t.string :title
      t.text :description
      t.string :image
      t.string :slug

      t.timestamps
    end
  end
end

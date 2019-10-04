class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.references :week
      t.string :slug

      t.timestamps
    end
  end
end

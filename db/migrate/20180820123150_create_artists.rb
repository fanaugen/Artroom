class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :nationality
      t.text :biography
      t.string :birthday
      t.string :deathday
      t.string :location

      t.timestamps
    end
  end
end

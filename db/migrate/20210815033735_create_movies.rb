class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :rating
      t.text :description
      t.datetime :release_date

      t.timestamps
    end
    
  def down
    drop_table 'movies' # deletes the whole table and all its data!
    end
  end
end

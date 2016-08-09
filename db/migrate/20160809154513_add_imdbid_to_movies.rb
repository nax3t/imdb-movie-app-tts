class AddImdbidToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :imdb_id, :string
  end
end

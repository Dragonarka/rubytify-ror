class AddGenreToArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :genre, :json
  end
end

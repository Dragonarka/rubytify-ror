class Artist < ApplicationRecord
    validates_presence_of :name, :image, :popularity, :genre, :spotify_url, :spotify_id
    has_many :albums
    has_many :songs, through: :albums

end

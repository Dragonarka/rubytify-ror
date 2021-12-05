class Album < ApplicationRecord
    validates_presence_of :name, :image, :spotify_url, :spotify_id
    belongs_to :artist
    has_many :songs
end

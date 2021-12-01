class Artist < ApplicationRecord
    validates_presence_of :name, :image, :popularity, :spotify_url, :spotify_id
end

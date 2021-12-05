class Song < ApplicationRecord
    validates_presence_of :name,:spotify_url, :duration_ms, :explicit, :spotify_id
    belongs_to :album
end

module Api
  module V1

    class ArtistSerializer < ActiveModel::Serializer
      attributes :id, :name, :image, :genre, :popularity, :spotify_url
    end
  end
end
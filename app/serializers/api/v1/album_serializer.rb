module Api
  module V1

    class AlbumSerializer < ActiveModel::Serializer
      attributes :id, :name, :image, :spotify_url, :total_tracks
    end
  end
end
module Api
  module V1
    class SongSerializer < ActiveModel::Serializer
      attributes :name, :spotify_url, :preview_url, :duration_ms, :explicit
    end
  end 
end

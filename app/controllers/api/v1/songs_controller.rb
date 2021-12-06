module Api
    module V1
        class SongsController < ApplicationController       

            def index
                songs = Album.find(params[:album_id]).songs
                render json: {data: ActiveModelSerializers::SerializableResource.new(songs, each_serializer: SongSerializer)},status: :ok
            end

            def random_song
                p params[:genre_name]
                genre = Artist.where(params[:genre_name])
                p genre
                #genre = Artist.where("cast(genres AS VARCHAR) LIKE ?", "%\"#{params[:genre_name]}\"%")
                artist = genre.sample
                songs = artist.albums.sample.songs.sample
                render json: {data: ActiveModelSerializers::SerializableResource.new(songs, each_serializer: SongSerializer)},status: :ok
              end

        end
    end 
end

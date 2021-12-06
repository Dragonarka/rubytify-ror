module Api
    module V1
       class ArtistsController < ApplicationController

        def index
            artists = Artist.all.order(popularity: :desc)
            render json: {data: ActiveModelSerializers::SerializableResource.new(artists, each_serializer: ArtistSerializer)},status: :ok
        end

        end 
    end
end


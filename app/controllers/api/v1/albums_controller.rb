module Api
    module V1
      class AlbumsController < ApplicationController
            
            def index                
                albums = Artist.find(params[:artist_id]).albums
                render json: {data: ActiveModelSerializers::SerializableResource.new(albums, each_serializer: AlbumSerializer)},status: :ok
                
            end
       
        end
    end
end

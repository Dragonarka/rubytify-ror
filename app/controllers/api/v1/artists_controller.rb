module Api
    module V1
       class ArtistsController < ApplicationController

    def index
        artists = Artist.all
        render json: {artists: artists},status: :ok
    end

end 
    end
end


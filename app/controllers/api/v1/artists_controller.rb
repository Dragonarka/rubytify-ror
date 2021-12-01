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
RSpotify.authenticate("c83a2169162f401fbba2a4bd88d55ac6", "d5e10e45717149a59a0029c4558c8475")

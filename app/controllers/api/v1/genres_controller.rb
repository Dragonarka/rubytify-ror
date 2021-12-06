module Api
    module V1
        
        class GenresController < ApplicationController
            
            def random_song
                
                song = :null                   
                artists = Artist.all
                artists.each do |artist|
                    #p index, artist
                    artist.genre.each do |genre, index|
                        #p genre,indey
                        if genre==params[:genre_name]
                            song = artist.albums.sample.songs.sample
                            #json_response({data:"The gender #{params[:genre_name]} does not match our database" })
                            break                                   
                        end                     
                    end
                end
                json_response({data: ActiveModelSerializers::SerializableResource.new(song, each_serializer: SongSerializer)})                
            end  

            def json_response(object, status = :ok)
                render json: object, status: status
            end

        end    
    end 
end



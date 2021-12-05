class SeedsSpotifyImporter
    
    def import        
        file = YAML.load_file('artists.yml')['artists']        
        file.each do |name|
            set_data_by_artist name    
        end
    end

    private

    def set_data_by_artist name

        sleep(0.5)  # to avoid toomanyrequest error

        sp_artist = get_artist_from_api name.to_s  #First step: go for single artist        
        
        sp_artist_formated = map_artist_data(sp_artist)  #Parse the objects artist to artist local

        artist_local = save_artist(sp_artist_formated) #Save or update the artist        

        sp_albums_formated = map_and_save_album_data(artist_local, sp_artist)  # Parse and save the album data with its songs

    end
 
    ##### BEGINNING OF ARTIST CONCERN
    def get_artist_from_api name
        RSpotify::Artist.search(name).first 
        #p "found #{name}"
      rescue
        return {mssg: "#{name} not found"}
    end

    def map_artist_data sp_artist
        artist_data = {
            name: sp_artist.name,
            image: sp_artist.images.first['url'],
            genre: sp_artist.genres,
            popularity: sp_artist.popularity,
            spotify_url: sp_artist.external_urls['spotify'],
            spotify_id: sp_artist.id
          }
    end

    def save_artist sp_artist_formated
        Artist.find_or_create_by(spotify_id: sp_artist_formated[:spotify_id]).update!(sp_artist_formated)  
        artist_local = Artist.find_by(spotify_id: sp_artist_formated[:spotify_id])
    end
   ####### END OF ARTIST CONCERN

   ###### BEGINNING OF ALBUM CONCERN
    def map_and_save_album_data (local_artist, sp_artist)
        sp_artist.albums.each do |album|
            
            album_data = {
              name: album.name,
              image: album.images.first['url'],
              spotify_url: album.external_urls['spotify'],
              total_tracks: album.total_tracks,
              spotify_id: album.id,
              artist_id: local_artist.id
            }
            album_local = save_album(album_data)            
            map_and_save_albums_songs(album_local, album)
          end
    end

    def save_album (album_data)
        Album.find_or_create_by(spotify_id: album_data[:spotify_id]).update!(album_data)        
        album_local = Album.find_by(spotify_id: album_data[:spotify_id])
    end

    ###### END OF album CONCERN

    ###### BEGINNING OF song CONCERN
    def map_and_save_albums_songs(album_local, sp_album)
        sp_album.tracks.each do |song|
            song_data = {
              name: song.name,
              spotify_url: song.external_urls['spotify'],
              preview_url: song.preview_url,
              duration_ms: song.duration_ms,
              explicit: song.explicit,
              spotify_id: song.id,
              album_id: album_local.id
            }            
            save_song(song_data)
          end
    end

    def save_song (song_data)
        Song.find_or_create_by(spotify_id: song_data[:spotify_id]).update!(song_data)
    end
    ####### END OF song CONCERN    

end
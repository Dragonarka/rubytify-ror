namespace :artists_import do
  desc "Importing from Spotify Api..."
  task :artists => [ :environment ] do
    p "Import rake task begins at #{DateTime.now}"
    SeedsSpotifyImporter.new.print "Intetaction Variable"
    p "Import rake task ended at #{DateTime.now}"
  end
end
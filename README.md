  

# Rubitify

  

the planning for this project can be found here: [Agile dashboard](https://trello.com/b/sBHnCLEI/rubytify)

  

You'll need to follow some instructions to get this project running:  

First of all this project is running in a cluster on this direction:

https://rubitify-ror.herokuapp.com

so you can launch all the services requested the services like this:  

https://rubitify-ror.herokuapp.com/api/v1/artists

  

https://rubitify-ror.herokuapp.com/api/v1/albums/1/songs

  

https://rubitify-ror.herokuapp.com//api/v1/artists/1/albums

  

https://rubitify-ror.herokuapp.com/api/v1/genres/metal/random_song

  

## 1: Requirements

  

You must have [Docker](https://docs.docker.com/) and

[Docker Compose](https://docs.docker.com/compose/) on your machine.

You can install these with:

*  [Docker for Mac](https://docs.docker.com/docker-for-mac/) on macOS

*  [Docker for Windows](https://docs.docker.com/docker-for-windows) on Windows

  

## 2: Clone & Run the project
 

You should clone the project into a conveniently-named directory, as this repo's name is big enough

to make typing docker/compose commands tiresome, should the need arise:
```
git clone https://github.com/Dragonarka/rubytify-ror.git rubitify\

&& cd rubitify\

&& docker-compose up -d app \

&& docker-compose logs -f

```


Watch it as it starts all the containers, and how the app database is initialized upon the first run

before starting the rails web server You are going to need some enviroment variables:
Originally there was some setup to be made prior to running the app. Fortunately a lot of changes

happened since then, and although the .env file is mandatory


this is the variables that we need to set up

```

DATABASE_NAME=d5v...
DATABASE_USER=ygp...
DATABASE_PASSWORD=f16c...
DATABASE_HOST=ec2-...
DATABASE_URL=postgres://ygp...:f16c1f8...@ec2....compu...amazonaws.com:54.../d5v3...
RAILS_ENV=deve...
SPOTIFY_URL=1
SPOTIFY_CLIENT_ID=c83a21...
SPOTIFY_CLIENT_SECRET=d5e10...

```

Docker Compose now reads the `/.env` file by default, if it exists. You can still add other dotenv

files and reference them in the `docker-compose.yml` file, but that would require an additional step

than the coveted 'clone and run' project setup.

if there is no problems, you'll have this output when you ran:
```

$ docker-compose up -d

  

[+] Running 2/2

- Container rubytify-ror-db-1 Created 0.0s

- Container rubytify-ror-web-1 Created 2.7s

```
## 4: Bring online the project's containers


Here there are some recomendations and tips to work arroundthis ptoject wich means that is only for development purposes:

To Login into the app container
```
docker-compose exec app sh
```
  

To run rspec in container:
```
docker-compose run -e "RAILS_ENV=test" app bundle exec rspec spec/link/to/file.rb
```
 To run the image with database from local to remote:
```
docker-compose up
```
 But you are going to need more env variables in this case, please make sure you enable the remote database:
```
export DATABASE_CLEANER_ALLOW_PRODUCTION=true

export DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true
```

That's it! Check the running app web interface: [http://localhost:3000](http://localhost:3000)

  

## 5: Apply the database migrations
```
rake db:migrate
```
To deploy in heroku container you can
```
heroku container:push web

heroku container:release web
```
Migrate the database on Heroku. This is required if we’ve pushed up a migration file.
```
heroku run rake db:migrate
```


You can also run the project without docker  

make sure you have this env variable

export DATABASE_URL=postgres://yg.......

then just

rails server -e development -p 4000

  


# TEST

  

bundle exec rspec



# License  

This is free software, and may be redistributed under the terms specified in the MIT License
  


# Models

Here we have how the models were generated:  

1. rails generate model XXXX

and also how the controllers were generated: 

2. rails generate controller XXXX

  
The initial model looks like this, you can verify it with the first migration, then we added indexes and foreign keys:
```
artist: rails generate model artist name:string image:text popularity:integer spotify_url:text spotify_id:string
```
  
```
album: rails generate model album name:string image:text spotify_url:text total_tracks:integer spotify_id:string
```
```
song: rails generate model song name:string spotify_url:text preview_url:text duration_ms:integer explicit:boolean spotify_id:string
```
```
genre:y rails generate model genre name:string
```
```
genre_artist: rails generate model artists_genres name:string
```

  

As Requeste we Build some serializars in order to match the output structure of the endpoint. Here we have the logic we have followed.

1. Artists
```
string - name
text - image(Any image of the artist)
json - genres
int - popularity
text - spotify_url
string - spotify_id
```
  
2. Fields you need to fetch for albums:
```
s - name
t - image(Any image of the album)
t - spotify_url
i - total_tracks
s - spotify_id
  ```

3. Fields you need to fetch for songs:
```
s - name
t - spotify_url
t - preview_url(30 second audio)
i - duration_ms
b - explicit
s - spotify_id
```
  
# TO RESET DATABASE
```
heroku pg:reset ENV[database_url] 
  ```

# to add columns

rails generate migration add_album_to_songs album:references  

rails g migration change_data_type_for_genre_to_json :artist, :genre, :json  
  
  

# To Build serializers
  
```
rails g serializer artist
```
```
rails g serializer album
```
```
rails g serializer song
```
   

# Rake ROUTES
```
Prefix Verb URI Pattern Controller#Action

- api_v1_artist_albums GET /api/v1/artists/:artist_id/albums(.:format) api/v1/albums#index

- api_v1_artists GET /api/v1/artists(.:format) api/v1/artists#index

- api_v1_album_songs GET /api/v1/albums/:album_id/songs(.:format) api/v1/songs#index

- api_v1 GET /api/v1/genres/:genre_name/random_song(.:format)
```

# TODO
1.  WE HAVE SKYPPED 311 DUE TO ERRORS with the album "album Voyager (Instrumentals)"
```
rake aborted!

NoMethodError: undefined method `[]' for nil:NilClass
```
SOLUTION: he can implement a retry strategy, or just debug the app and watch what is going on with that album.  Rescue request with retry https://stackify.com/rescue-exceptions-ruby/

2. WE HAVE TO ADD SPECIFIC TEST CASES TO THE RSPEC, ACTUALLY RSPEC HAS THE COMMON CONFIGURATION

3. THE RANDOM SERVICE WORKS BUT IS NOT TOTALLY RANDOM EVERY TIME YOU ASK FOR IT
 
   # ISSUES


```
standard_init_linux.go:228: exec user process caused: no such file or directory

In entrypoint docker ->docker-entrypoint.sh
```
you can fix it just with the change of CRLF to LF in your bash files.

- Use notepad++, go to edit -> EOL conversion -> change from CRLF to LF.  

- update: For VScode users: you can change CRLF to LF by clicking on CRLF present on lower right side in the status bar

  


# Rubitify

the planning for this project can be found here: [Agile dashboard](https://trello.com/b/sBHnCLEI/rubytify)

You'll need to follow some instructions to get this project running:

## 1: Requirements

You must have [Docker](https://docs.docker.com/) and
[Docker Compose](https://docs.docker.com/compose/) on your machine.

You can install these with:
  * [Docker for Mac](https://docs.docker.com/docker-for-mac/) on macOS
  * [Docker for Windows](https://docs.docker.com/docker-for-windows) on Windows

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
before starting the rails web server.

if there is no problems, you'll have this output:
```
$ docker-compose up -d

[+] Running 2/2
 - Container rubytify-ror-db-1   Created                                                                   0.0s 
 - Container rubytify-ror-web-1  Created                                                                   2.7s
```
## 3: Initialize the app environment in an initial run:

Originally there was some setup to be made prior to running the app. Fortunately a lot of changes
happened since then, and although the dotenv file is recommended, it is not required for the project
to run immediately after cloning.

If you need to, however, you can copy the contents of the example dotenv file into a file
called `.env`:

```
cp example.env .env
```
this is the variables that we need in this example
```
DATABASE_NAME=
DATABASE_USER=
DATABASE_PASSWORD=
DATABASE_HOST=
```
Docker Compose now reads the `/.env` file by default, if it exists. You can still add other dotenv
files and reference them in the `docker-compose.yml` file, but that would require an additional step
than the coveted 'clone and run' project setup.

## 4: Bring online the project's containers

```
docker-compose up -d
```

Only for development purposes: 
Login into the app container
docker-compose exec app sh

To run rspec in container:
docker-compose run -e "RAILS_ENV=test" app bundle exec rspec spec/link/to/file.rb


## 5: Apply the database migrations
```
heroku container:push web
heroku container:release web
Migrate the database on Heroku. This is required if we’ve pushed up a migration file.
heroku run rake db:migrate
```

Then run again:
```
docker-compose up -d
```

That's it! Check the running app web interface: [http://localhost:3000](http://localhost:3000)

You can also run the project without docker

make sure you have this env variable
export DATABASE_URL=postgres://yg.......
 then just
  rails server -e development -p 4000

HEROKU


heroku container:push web
heroku container:release web

TEST

bundle exec rspec

MIGRATIONS
rails db:migrate

# License

This is free software, and may be redistributed under the terms specified in the MIT License


# ERRORS

1. standard_init_linux.go:228: exec user process caused: no such file or directory
In entrypoint docker ->docker-entrypoint.sh

Use notepad++, go to edit -> EOL conversion -> change from CRLF to LF.

update: For VScode users: you can change CRLF to LF by clicking on CRLF present on lower right side in the status bar

# Models

rails generate model
rails generate controller artists

artist:  rails generate model artist name:string image:text g
enres:integer popularity:integer spotify_url:text spot
ify_id:string

album
song
gender

Fields you need to fetch for artists:
string - name
text  - image(Any image of the artist)
fk  - genres(You must record all of them)
int  - popularity
text  - spotify_url
string  - spotify_id

Fields you need to fetch for albums:
s  - name
t  - image(Any image of the album)
t - spotify_url
i - total_tracks
s  - spotify_id

Fields you need to fetch for songs:
s  - name
t  - spotify_url
t  - preview_url(30 second audio)
i  - duration_ms
b  - explicit
s  - spotify_id


to test locally:
export DATABASE_CLEANER_ALLOW_PRODUCTION=true
export DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true




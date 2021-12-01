FactoryBot.define do
    factory :artist do
        name { Faker::Name.name }
        image {'https://imggur.com'}
        popularity {50}
        spotify_url {'open.spotify.com/listen/tyui465tyui5465u'}
        spotify_id {'tyui465tyui5465u'}
    end
end
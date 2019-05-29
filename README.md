# Sofar Sounds Music Video Search API

This project is to satisfy the requirements outlined in the Sofar Sounds Backend Test
(https://github.com/sofarsounds/backend-tech-test), which are to import data from an
external file hosted on Amazon and allow it to be searched via an API.

To satisfy these requirements, I have built a Rails app (Rails version 5.2.3,
Ruby version 2.6.1) that exposes a simple index action enabling the searching of music
videos by song name, artist name, and/or city. To add some basic text searching support,
I used the FULL TEXT indexing functionality available within MySQL
(https://dev.mysql.com/doc/refman/8.0/en/fulltext-search.html). This indexing strategy
would need to be reviewed based on requirements such as expected growth of dataset,
uniqueness/distribution of words across data set, etc.

## Dependencies
(On Mac only) Inst all Xcode tools: `xcode-select --install`

[gorails](https://gorails.com/setup/) has a great up to date setup guide, which covers a number of the remaining dependencies listed below:
* [Homebrew](https://brew.sh/)
* [RVM](https://github.com/rvm/rvm) my preferred tool for ruby version management, but you can also use rbenv.
* [Ruby](https://www.ruby-lang.org/en/). This project was developed using one of the more recent stable versions of Ruby: `rvm install 2.6.1`
* [Bundler](https://bundler.io/) which is used to manage gem dependencies: `gem install bundler`
* [Ruby on Rails](https://rubyonrails.org/).
* [MySQL](https://dev.mysql.com/doc/refman/8.0/en/osx-installation.html) 


## Build and Run
* Clone the repository locally into your preferred directory: `git clone https://github.com/prangarang/music-video.git`
* cd into project `cd music_video`
* install gem dependencies: `bundle install`
* Create DB/DB Schema and seed the database with data from S3: `bundle exec rake db:create db:migrate db:seed`
* Start the rails server: `bin/rails server`
* Test API: `curl -v -H "Accept: application/json" "http://localhost:3000/music_videos?song_name=reading&city=LoNdon"`

## Tests
To run rspec test suite run: `bundle exec rspec spec/`

## Project Next Steps
Below are some additional things to focus on in future.
* Importing
    * After understanding more about the data quality requirements, decide how to handle
    records missing specific metadata. Should it be skipped? Should it be flagged for
    review with external source provider?
    * If number of records increases in future, look into possible improvements such as
     processing/inserting in batches and how to work around potential issue that insertion
     into table with index is slower than adding index later.
    * If requirement to perform continual updates is required, update importer based on
    how updates are reflected in external data source (update in place or new row for each
    change).
* Model
    * Based on knowledge of external dataset, consider making video_uid a unique key to
    support importing.
* API
    * As usage of API is fleshed out consider releasing new version of API with different
    JSON response format.
    * Find out requirements for exposing records with missing metadata.
    * Expose a show action to support re-fetching of specific records by video_uid.
* Searching/Indexing
    * Figure out requirements for commonly used words such as 'the' as this will likely help inform future indexing strategy/configuration
* Tests
    * For tests requiring the search functionality, figure out a more elegant way to
    handle the fact that rspec tests run within a transaction and testing searching
    requires transactions to be committed. This appears to be the case for other searching
    solutions such as elastic search. See `spec/support/shared_examples.rb` for further
    explanation.
    * Figure out preferred directory organization of tests with Team


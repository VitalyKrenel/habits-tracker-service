# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


## Instructions:
    1. docker-compose build

If there some problems, check and fix `Gemfile`, and update `Gemfile.lock` with command: ```docker-compose run web bundle```

    2. docker-compose up -d

    3. docker-compose exec web rails db:seed (only first start)

    4. Go to http://localhost:3000

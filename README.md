# Dependencies

- Ruby 2.7.1
- Rails 6.1.3
- Postgres 13
- Yarn
- Poppler (For pdf preview generation)
- Imagemagick

# Setup and Running the Server

1. Clone the repo
1. Install dependencies with `bundle install` and `yarn install`
1. Setup and seed the database `rails db:setup`
1. Run the server `rails s`

# Poppler

Poppler is required to generate PDF preview urls. Heroku has a
[recommended buildpack](https://github.com/heroku/heroku-buildpack-activestorage-preview) for ActiveStorage that includes FFMPEG and Poppler which has been
added to the application's buildpacks.

You may install it on MacOS via `brew install poppler`

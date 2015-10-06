# Fanatic Sports

Fanatic Sports is a rails based web application designed to socialize sports blogging. Users can follow their favorite teams, create posts and read other sports fans posts.

## Developer Environment Setup

This setup assumes you are using a recent version of OS X and have [Homebrew](http://brew.sh/) installed.

1. Clone this repo
2. Navigate to the repo on your local machine
3. Install [rbenv](https://github.com/sstephenson/rbenv)
4. Install Ruby by entering `rbenv install $(cat ./.ruby-version)`. This installs the version of Ruby that is specified in `.ruby-version` in this repo.
5. Verify the correct version of Ruby is installed by entering `rbenv version`. The output should be something like `2.1.5`. Additionally, verify that `ruby --version` output is something like `ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-darwin14]`
6. Install [Bundler](http://bundler.io/) by entering `gem install bundler` and then run `rbenv rehash`
7. Install application dependencies by entering `bundle install`
8. Install PostgreSQL using Homebrew by entering `brew install postgresql` and then initialize PostgreSQL `postgres -D /usr/local/var/postgres`
9. Then initialize the PostgreSQL database by entering `pg_ctl initdb -D /usr/local/pgsql/data`
10. Create the application databases by entering `bundle exec rake db:create:all`
11. Migrate the application databases by entering `bundle exec rake db:migrate RAILS_ENV=development` and `bundle exec rake db:migrate RAILS_ENV=test`
12. Start the Ruby on Rails server by entering `bin/rails server`
13. Open a browser on your local machine and navigate to localhost:3000 and enjoy!

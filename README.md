# workforwardnola
Job seeker focused website for NOLA

http://workforwardnola.com

## Dev setup
Requires Ruby 2.2.5 and Postgres (9.5+ preferred).

After cloning the repository for the first time, run `bundle install` in the `workforwardnola` directory.

### Database Setup
Make sure [Postgres is installed](https://devcenter.heroku.com/articles/heroku-postgresql#set-up-postgres-on-mac): `which psql` should give a reasonable answer. Also create a file called `.env` with the line `DATABASE_URL=postgres://localhost:5432/workforwardnola`. (You may need to create a new DB in postgres called `workforwardnola`.)

Run `rake db:migrate` and `rake db:seed` to set up the database structure and fill it with sample data. If the data doesn't show up, try running `rake db:reset` and `rake db:seed`.

### Running app & deployment
Run the app by running `bin/start`. It will be available at [http://localhost:9292](http://localhost:9292). If there are errors when you try to refresh to see changes, try again - you may have been faster than the app regenerated.

Deployment is via heroku. Staging: wfn-staging.herokuapp.com (current with master). Review apps are enabled for all pull requests.

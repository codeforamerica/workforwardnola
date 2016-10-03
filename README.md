# workforwardnola
Job seeker focused website for NOLA

http://workforwardnola.com

## Dev setup
Requires Ruby 2.2.5 and Postgres (9.5+ preferred).

After cloning the repository for the first time, run `bundle install` in the `workforwardnola` directory.

Copy `.env.example` to a new file called `.env`. You can leave the admin password as-is for development, or change it.

### Database Setup
Make sure [Postgres is installed](https://devcenter.heroku.com/articles/heroku-postgresql#set-up-postgres-on-mac): `which psql` should give a reasonable answer. Also create a file called `.env` with the line `DATABASE_URL=postgres://localhost:5432/workforwardnola`. (You may need to create a new DB in postgres called `workforwardnola`.)

Run `rake db:migrate` and `rake db:seed` to set up the database structure and fill it with sample data. If the data doesn't show up, try running `rake db:reset` and `rake db:seed`. Career data can also be loaded via [http://localhost:9292/manage](http://localhost:9292/manage). and a spreadsheet.

### Running app & deployment
Run the app by running `bin/start`, all it does is call `rerun -p "**/*.{rb,js,scss,mustache,ru,jpg,jpeg,png}" rackup`. The site will be available at [http://localhost:9292](http://localhost:9292). If there are errors when you try to refresh to see changes, try again - you may have been faster than the app regenerated.

Deployment for collaborators is via heroku. Staging: wfn-staging.herokuapp.com (synced with master). Review apps are enabled for all pull requests. 

The "Email to yourself" career assessment feature requires the `EMAIL_***` config variables to be set. We use the [pony](https://github.com/benprew/pony) gem to send emails, please see their documentation for more details.

## Deploying to production
Two config variables need to be set, regardless of deployment: `ADMIN_USER` and `ADMIN_PASSWORD`. Career data is loaded via [http://your_url_here/manage](http://<your url here>/manage).

### Heroku
Setting up a Heroku pipeline is relatively straightforward. We have set up a pipeline with a staging app (with automatic deploys from the master branch), production app (we periodically promote the app from staging to production), and review apps are enabled. We use the Postgres add-on.

### AWS
For AWS, we roughly followed the steps for the [AWS with Sinatra](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_Ruby_sinatra.html) setup, selecting the Ruby 2.2 with Puma configuration. We also created an integrated Postgres database instance (v. 9.5.2) as described in [this documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.managing.db.html). PR #108 contains the code and configuration changes we made to the app to get it to work with AWS (Elastic Beanstalk), and some of the process is described in #106.

## Updating content
For details on updating content see other files under the `docs/` folder. Details on updating career info via spreadsheet specifically is in [docs/career_assessment_how_to.md](docs/career_assessment_how_to.md).

# workforwardnola
Job seeker focused website for NOLA. There is a version live at http://careerpathnola.com (hosted by the City of New Orleans).

## Dev setup
Requires Ruby 2.2.5 and Postgres (9.5+ preferred).

After cloning the repository for the first time, run `bundle install` in the `workforwardnola` directory.

Copy `.env.example` to a new file called `.env`. You can leave the admin password as-is for development, or change it.

### Database Setup
Make sure [Postgres is installed](https://devcenter.heroku.com/articles/heroku-postgresql#set-up-postgres-on-mac): `which psql` should give a reasonable answer. Also create a file called `.env` with the line `DATABASE_URL=postgres://localhost:5432/workforwardnola`. (You may need to create a new DB in postgres called `workforwardnola`.)

Run `rake db:migrate` and `rake db:seed` to set up the database structure and fill it with sample data. If the data doesn't show up, try running `rake db:reset` and `rake db:seed`. Career data can also be loaded via [http://localhost:9292/manage](http://localhost:9292/manage). and a spreadsheet.

### Running app & deployment
Run the app by running `bin/start`, with an optional command line argument `"$IP:$PORT"`, all it does is call `rerun -p "**/*.{rb,js,scss,mustache,ru,jpg,jpeg,png}" rackup`. The site will be available at [http://localhost:9292](http://localhost:9292). If there are errors when you try to refresh to see changes, try again - you may have been faster than the app regenerated.

The Code for America NOLA fellows team is no longer actively developing this. We had set up a deployment pipeline via heroku, syncing the staging site with the master branch and enabling review apps for pull requests. It worked well!

The "Email to yourself" career assessment feature requires the `EMAIL_xxxx` config variables to be set. We use the [pony](https://github.com/benprew/pony) gem to send emails, please see their documentation for more details.

## Updating content
For details on updating content see other files under the `docs/` folder. Details on updating career info via spreadsheet specifically is in [docs/career_assessment_how_to.md](docs/career_assessment_how_to.md).

## Deploying to production
The `ADMIN_xxxx` and `EMAIL_xxxx` config variables need to be set regardless of the deployment. `ADMIN_USER` and `ADMIN_PASSWORD` protect the `/manage` part of the site, and the `EMAIL_xxxx` variables are for the [pony](https://github.com/benprew/pony) gem. After the app is up, make sure to load the career data via [http://your_url_here/manage](http://your_url_here/manage).

### Redeploying for another city
Most of the content is specific to New Orleans and the Opportunity Centers, including which careers are highlighted.

### Heroku
Setting up a Heroku pipeline is relatively straightforward. We set up a pipeline with a staging app (with automatic deploys from the master branch), production app (we periodically promote the app from staging to production), and review apps enabled. We used the Postgres add-on.

### AWS
We are not AWS experts, so if you have recommendations to improve the following, please make a PR! **We found that this requires at least a t2.micro instance to avoid out of memory errors during deployment.**

1. Create an IAM user (as recommended by Amazon) with appropriate permissions for deployment credentials. @antislice has no idea what specific permissions are needed for EB deployment, so we tested with admin.
2. Install the Elastic Beanstalk client.
2. Follow the Create an Application steps in [this documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_Ruby_sinatra.html#create_deploy_Ruby_eb_init).
  * For steps 5/6, select `Ruby` and `Ruby 2.2 (Puma)`
  * SSH login is optional, but convenient
3. At this point, you'll want to set up the DB. We created an integrated Postgres database instance (v. 9.5.2) as described in [here](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.managing.db.html).
4. Walk through [Create an Environment](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_Ruby_sinatra.html#create_deploy_Ruby_eb_env)
5. ‼️ At this point, stop and check on the instance type. You may need to configure a VPC.
6. Try deploying: `eb deploy`

Configuring the "email to yourself" feature requires extra configuration on EB.

Further notes on our initial test deployment and changes that were made:
* [PR #108](https://github.com/codeforamerica/workforwardnola/pull/108) contains the code and configuration changes we made to the app to get it to work with AWS (Elastic Beanstalk)
* Some of the process is described in [#106](https://github.com/codeforamerica/workforwardnola/issues/106)

# workforwardnola [![CodeFactor](https://www.codefactor.io/repository/github/loyno-mathcs/workforwardnola/badge)](https://www.codefactor.io/repository/github/loyno-mathcs/workforwardnola) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/c6e79f4eeece4ae1a4d60cba9943f5ed)](https://www.codacy.com/app/nihonjinrxs/workforwardnola?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=loyno-mathcs/workforwardnola&amp;utm_campaign=Badge_Grade) [![codebeat badge](https://codebeat.co/badges/3384331f-ae8f-494f-a568-a1a23dc493a7)](https://codebeat.co/projects/github-com-loyno-mathcs-workforwardnola-master) [![Travis CI](https://travis-ci.org/loyno-mathcs/workforwardnola.svg?branch=master)](https://travis-ci.org/loyno-mathcs/workforwardnola)

Job seeker focused website for NOLA. There is a version live at http://careerpathnola.com (hosted by the City of New Orleans).

## Dev setup
Requires Ruby 2.5.3 and Postgres (9.5+ preferred). You may need to use a differing version of Ruby, depending on deploy method (see the AWS section below)

After cloning the repository for the first time, run `bundle install` in the `workforwardnola` directory.

Copy `.env.example` to a new file called `.env`. You can leave the admin password as-is for development, or change it.

### Database Setup

Make sure [Postgres is installed](https://devcenter.heroku.com/articles/heroku-postgresql#set-up-postgres-on-mac): `which psql` should give a reasonable answer. Also create a file called `.env` with the line `DATABASE_URL=postgres://localhost:5432/workforwardnola`. (You may need to create a new DB in postgres called `workforwardnola`.)

Run `rake db:migrate` and `rake db:seed` to set up the database structure and fill it with sample data. If the data doesn't show up, try running `rake db:reset` and `rake db:seed`. Career data can also be loaded via [http://localhost:9292/manage](http://localhost:9292/manage). and a spreadsheet.

### Running app & deployment

Run the app by running `bin/start`, with an optional command line argument `"$IP:$PORT"`, all it does is call `rerun -p "**/*.{rb,js,scss,mustache,ru,jpg,jpeg,png}" rackup`. The site will be available at [http://localhost:9292](http://localhost:9292). If there are errors when you try to refresh to see changes, try again - you may have been faster than the app regenerated.

The Code for America NOLA fellows team is no longer actively developing this. We had set up a deployment pipeline via heroku, syncing the staging site with the master branch and enabling review apps for pull requests. It worked well!

The "Email to yourself" career assessment feature requires the `EMAIL_xxxx` config variables to be set. We use the [pony](https://github.com/benprew/pony) gem to send emails, please see their documentation for more details.

Some changes have included various AWS services. In addition to SMTP from the pony gem, several config variables must be set for AWS services (S3 and SES). These are new additions added below the `EMAIL_xxxx` config variables.

Setting up SES: `SENDER_EMAIL`, `OWNER_EMAIL`, `AWS_ACCESS`, `AWS_SECRET` must all be configured in `.env` for the SES to work through the job form.

Setting up S3: Configure `AWS_BUCKET` in `.env`

## Job System Results 

There is additionally an optional feature to write to GoogleSsheets using a file `client_secret.json`. An example is included in `client_secret.json.example`. If you do not wish to use this feature, do not create or use `client_secret.json`! You can find information on the [google-drive-ruby](https://github.com/gimite/google-drive-ruby) GitHub.
This feature requires setting up a Google Service Account. You can find more information in [Google's documentation](https://cloud.google.com/iam/docs/service-accounts)

## Updating content

For details on updating content see other files under the `docs/` folder. Details on updating career info via spreadsheet specifically is in [docs/career_assessment_how_to.md](docs/career_assessment_how_to.md).
Updating Opportunity Centers is now done through the Management page instead of changing through text.

## Deploying to production

The `ADMIN_xxxx` and `EMAIL_xxxx` config variables need to be set regardless of the deployment. `ADMIN_USER` and `ADMIN_PASSWORD` protect the `/manage` part of the site, and the `EMAIL_xxxx` variables are for the [pony](https://github.com/benprew/pony) gem. After the app is up, make sure to load the career data via [http://your_url_here/manage](http://your_url_here/manage).

### Redeploying for another city

Most of the content is specific to New Orleans and the Opportunity Centers, including which careers are highlighted.

### Heroku

Setting up a Heroku pipeline is relatively straightforward. We set up a pipeline with a staging app (with automatic deploys from the master branch), production app (we periodically promote the app from staging to production), and review apps enabled. We used the Postgres add-on.

### AWS

We are not AWS experts, so if you have recommendations to improve the following, please make a PR! **We found that this requires at least a t2.micro instance to avoid out of memory errors during deployment.**

1. Create an IAM user (as recommended by Amazon) with appropriate permissions for deployment credentials. @antislice has no idea what specific permissions are needed for EB deployment, so we tested with admin.
2. Install the Elastic Beanstalk client. This is only be necessary if you are deploying to AWS from the command line. You can do this from the AWS Elastic Beanstalk UI.
  * NOTE: When setting up authentication for the CLI tools (so that you can later run `eb init` or `eb deploy`), you'll want a the user with deployment credentials -- more permissions than the service user that you'll use to run the service itself (which will only need access to the S3 bucket, elastic beanstalk components, and RDS instance).
3. Follow the Create an Application steps in [this documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_Ruby_sinatra.html#create_deploy_Ruby_eb_init).
  * For steps 5/6, select `Ruby` and `Ruby 2.5 (Puma)`
  * NOTE: AWS config only works on specific versions of Ruby. We went with 2.5.3. 
  * SSH login is optional, but convenient
4. At this point, you'll want to set up the DB. We created an integrated Postgres database instance (v. 9.5.2) as described in [here](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.managing.db.html).
  * You will need to configure Amazon RDS. Create a database and use the information from the DB to connect (this is important to do first before you upload and deploy)
  * An AWS RDS database will follow the same Database URL as the given format in `.ENV` as if you were running Postgres locally. You can find the necessary credentials in the RDS dashboard for your database instance.
  * When you are using AWS RDS, you might have to connect from outside to run migrations. To do this, go to your database instance, add a new inbound security rule for "Anywhere" IP, and then run your migrations locally/remotely, then remove the inbound security role.
5. Create an S3 Bucket for use in storing uploaded Resume files from the Job System form. Copying bucket policies from the Elastic Beanstalk auto-generated bucket works fine from what we've seen, or you can set specific permissions as needed.
6. Walk through [Create an Environment](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_Ruby_sinatra.html#create_deploy_Ruby_eb_env)
7. Create a source bundle if uploading through the UI. `zip ../filename.zip -r * .[^.]*`
8. ‼️ At this point, stop and check on the instance type. You may need to configure a VPC.
9. Try deploying: `eb deploy` or use the Upload and Deploy feature integrated into EB.
  * If the app is not working, try using a different Ruby version (e.g. 2.5.1). Note that this would mean testing to ensure all the Ruby gems work, especially if downgrading.

~~Configuring the "email to yourself" feature requires extra configuration on EB.~~
If you are using AWS SES SMTP service, this is no longer necessary as the emails will go through SES. We have set up an SMTP service, so all emails are going through a central location (AWS)

Further notes on our initial test deployment and changes that were made:
* [PR #108](https://github.com/codeforamerica/workforwardnola/pull/108) contains the code and configuration changes we made to the app to get it to work with AWS (Elastic Beanstalk)
* Some of the process is described in [#106](https://github.com/codeforamerica/workforwardnola/issues/106)

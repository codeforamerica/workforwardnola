# Career assessment
## How does it work?
Each "Me" or "Not Me" response is matched with a trait like "Adaptable" or "Organized". Each career is associated with a few traits. When results are calculated, each career is given a score to reflect how closely it matches the traits chosen by the job seeker. The three careers with the highest score are displayed.

Matching an image with a trait can happen three ways:
1. Positive association: responding "Me" to an image is a "Me" response to the trait (Example: 'Working with customers' -> 'Customer service')
2. Reverse association: responding "Not Me" to an image is a "Me" response to certain `reverse_trait`s (Example: 'Working with your hands' reverses to 'Technical')
3. Compound association: Some traits are hard to encapsulate in a single image, so "Me" responses to multiple images can also become a "Me" response to a higher-level trait (Example: 'Teamwork' and 'Self-starter' are parts of the 'Leadership' trait)

## How can I update the career information?
The career info is managed via a google spreadsheet that is manually synced with the site's database. Updating existing career info or adding a new career doesn't involve any code updates, but adding a new trait or changing the assessment does.

### The google spreadsheet
The current production version of this site uses [this spreadsheet](https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8) (current owners CfA NOLA Fellows).

*When editing the content DO NOT change the column headers or the content will not update properly.* The columns `description`, `	foundational_skills`, and `training` accept HTML formatting. It's recommended to double check your HTML with a tool like https://jsfiddle.net/.

The numbers in the `traits` column correspond to the `id` column in the traits spreadsheet tab. To add or remove a trait from a career, add or remove the corrsponding `id` number from the `traits` column (make sure they are comma-separated). See below for adding an entirely new trait to the spreadsheet.

#### Starting from scratch
If you're setting up a new copy of this site, use this google spreadsheet template: https://drive.google.com/previewtemplate?id=1vgqsoXLJ9FSDZamGv-SzDX_xCV3wHY0Lh142nhuZDQI&mode=public. After filling in the info, go to 'File' > 'Publish to Web' and publish it as a web page. Make sure "Automatically republish when changes are made" is checked at the bottom. Save the link! You can also get the link again by opening the "Publish to Web" dialog again.

### Updating career info
To update the information about a career: edit your spreadsheet, then go to the ["manage" page](http://workforwardnola.com/manage) & enter the username and password. Enter the PUBLIC link to the spreadsheet (it ends in `/pubhtml`) (Like https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8/pubhtml), wait for the link to be validated, then click "Update content".

### Adding new career
Add a new row to the google spreadsheet. The columns `name`, `sector`, and `experienced_wage` are required. The `traits` column is required to have the new career be included in assessment results. After filling in the new row in the spreadsheet, follow the instructions above to load the new information.

## Adding new trait
Adding a new trait to the assessment cannot be done without additional coding work.

1. Add the new trait(s) to the "traits" tab of the spreadsheet with an `id`. Add that `id` to the `traits` column of any career you wish to associate it with.
2. In `views/assessment.rb` the trait is associated with an image, other traits as a "compound trait", or as a "reverse trait"--the opposite of an image. The name of the trait must be entered somewhere in this file or it will not be part of the assessment.
3. Assessment images are saved in `/assets/images/assessment`

### Assessment pictures <-> traits
"Standard" traits:
If a user answers 'me', the `trait` is recorded, if the answer is 'not me', the `reverse_trait` is recorded.
```ruby
{ trait: 'Following instructions',    # must match name of trait from spreadsheet/database
  reverse_trait: 'Self-starter',      # optional, is 'inverse' of trait above
  title: 'Following instructions',    # text to display with image
  file: 'instructions.jpg' },         # file name of image (in /assets/images/assessment)
```
"Compound" traits:
A trait may be tricky to capture in a single image. Two or more _existing_ traits can be combined to form a compound trait. If a user checks 'me' for each of the components, a 'me' is recorded for the trait.
```ruby
{ trait: 'Perceptive',    # trait name
  components: ['Detail oriented', 'Customer service'] },  # names of simpler traits
```

## Adding or removing a column from the careers spreadsheet
If the case is you no longer want to show a specific piece of information, it can be left out of the HTML.

Otherwise, all these pieces need to be handled by a developer:
1. Write a [migration](http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html) to add or remove the column (there are examples in the code base)
2. Update the `#bulk_create` method in `models/career.rb`
3. Update the `#career_descriptions` method in `views/careers.rb`
4. Don't forget to reference it in the html somewhere!

For the changes to be applied after deployment:
1. Run migrations on the server: `rake db:migrate`
2. Restart server/dynos
3. Update data via spreadsheet

# Updating content

## HTML & page content
The basic html for each page can be found in a `*.mustache` file in the `/templates` directory.

* Homepage/front page: `index.mustache`
* Header & footer: `layout.mustache` (this "wraps" all the other pages)
* Assessment (me/not me quiz): `assessment.mustache` 
* Careers (results): `careers.mustache` (How to update the career content is covered below)

## Career assessment
### Updating career info
The careers are managed via a google spreadsheet (https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8, current owners CfA Fellows). To update the information about a career: edit that spreadsheet, then go to the ["manage" page](http://workforwardnola.com/manage) & enter the username and password. Enter the PUBLIC link to the spreadsheet (https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8/pubhtml), wait for the link to be validated, then click "Update content".

When editing the content DO NOT change the column headers or the content will not update properly. The columns `description`, `	foundational_skills`, and `training` accept HTML formatting. It's recommended to double check your HTML with a tool like https://jsfiddle.net/.

The numbers in the `traits` column correspond to the `id` column in the traits spreadsheet tab. To add or remove a trait from a career, add or remove the corrsponding `id` number from the `traits` column (make sure they are comma-separated). See below for adding an entirely new trait to the spreadsheet.

### Adding new career
Add a new row to the google spreadsheet. The columns `name`, `sector`, and `experienced_wage` are required. The `traits` column is required to have the new career be included in assessment results. After filling in the new row in the spreadsheet, go to the ["manage" page](http://workforwardnola.com/manage) & enter the username and password. Enter the PUBLIC link to the spreadsheet (https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8/pubhtml), wait for the link to be validated, then click "Update content".

### Adding new trait
Adding a new trait to the assessment cannot be done without additional coding work.

1. Add the new trait(s) to the "traits" tab of the spreadsheet with an `id`. Add that `id` to the `traits` column of any career you wish to associate it with.
2. In `views/assessment.rb` the trait is associated with an image, other traits as a "compound trait", or as a "reverse trait"--the opposite of an image. The name of the trait must be entered somewhere in this file or it will not be part of the assessment.
3. Assessment images are saved in `/assets/images/assessment`

#### Assessment pictures <-> traits
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
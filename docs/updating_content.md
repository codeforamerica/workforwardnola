# Updating content

## HTML & page content
The basic html for each page can be found in a `*.mustache` file in the `/templates` directory.

* Homepage/front page: `index.mustache`
* Header & footer: `layout.mustache` (this "wraps" all the other pages)
* Assessment (me/not me quiz): `assessment.mustache` 
* Careers (results): `careers.mustache` (How to update the career content is covered below)
* Signing up for the job system: `jobsystem.mustache`
* Text-only Opportunity Center information from map: `opp_center_info.mustache`

## Career assessment
The careers are managed via a google spreadsheet (https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8, current owners CfA Fellows). 

To update the information about a career: edit that spreadsheet, then go to the ["manage" page](http://workforwardnola.com/manage) & enter the username and password. Enter the PUBLIC link to the spreadsheet (https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8/pubhtml), wait for the link to be validated, then click "Update content".

When editing the content DO NOT change the column headers or the content will not update properly. The columns `description`, `general_duties`, `training`, `career_image`, and `alt_title` accept HTML formatting. It's recommended to double check your HTML with a tool like https://jsfiddle.net/. You will need to copy and paste your HTML in the tool, and run it to see the changes. 

The numbers in the `traits` column correspond to the `id` column in the traits spreadsheet tab. To add or remove a trait from a career, add or remove the corrsponding `id` number from the `traits` column (make sure they are comma-separated).

See [career_assessment_how_to.md](career_assessment_how_to.md) for all the details, including starting from a new spreadsheet and adding a new trait.

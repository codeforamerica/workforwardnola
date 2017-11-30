require 'bundler'
Bundler.require
 
# Authenticate a session with your Service Account
session = GoogleDrive::Session.from_service_account_key("client_secret.json")
 
# Get the spreadsheet by its title
spreadsheet = session.spreadsheet_by_title("Copy of Legislators 2017")
# Get the first worksheet
worksheet = spreadsheet.worksheets.first
# Print out the last column of each row
worksheet.rows.each { |row| puts row.last(1) }
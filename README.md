# AdServiceAPI

A rails backend api for the AdService homework project

## Instructions

Lines 43-55 contain the script to read over the csv, and translate the advertiser name and add the id to the csv. To import a database, make sure to comment out lines 60-90, then run `rake db:seed`. After the task finishes, open new_data.csv and delete the extra quotes around the header, comment out lines 43-55 and uncomment 60-90 and run `rake db:seed`

The seed of the data file should take around 30 seconds at MOST.

I have included the new_data.csv, which would be the result of running the scripts on line 43. To test the import script, just run `rake db:seed`

## Usage

Before seeding the file, I added an extra column to the CSV, with the header 'advertiser_id', and copied the advertiser name from the column of advertisers. In the seed script, a helper method translates the name of the advertiser to an id number, and associates the advertiser during the seed of all of the products. This is a little slower for having to edit the file, but ensures that only one pass is needed to instantiate the records and associate them to their advertisers.

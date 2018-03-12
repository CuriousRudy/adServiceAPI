# AdServiceAPI

A rails backend api for the AdService homework project

## Instructions

Make sure the path in the seeds.rb directory points to your CSV. Run `rake db:seed` and allow up to 3.5 minutes for the records to be inserted into the database. The initial seed takes about 3 minutes/1MM records, but also associates the Advertiser and the Product.

## Usage

Before seeding the file, I added an extra column to the CSV, with the header 'advertiser_id', and copied the advertiser name from the column of advertisers. In the seed script, a helper method translates the name of the advertiser to an id number, and associates the advertiser during the seed of all of the products. This is a little slower for having to edit the file, but ensures that only one pass is needed to instantiate the records and associate them to their advertisers.

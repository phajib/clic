#Sinatra Project - Overview

# Project App Overview

A Camera Crew Journal app. User creates entries logging date of shoot, equipment used, shoot location/s, client details, sample images and notes.


# User Shoot Logs

## Users will be able to...

## As a User, I can...
- Create an account
- Log a shooting day
- See all Logs
- Edit Logs
- Delete Logs

# Wireframing
(List Models, Listing Associations and Attributes of those Models)


## Models will be User and Log

## User

### Attributes
- UserName
- Name
- Email
- Password (using 'bycrypt', 'password_digest' is used in db)

### Associations
- has_many :logs


## Log

### Attributes
- shoot_title
- shoot_date
- notes
- camera
- lens
- speedlight
- accessories
- user_id  <-- foreign key

### Associations
- belongs_to :user

# MVP


# Strech Goals
- Like other members sample images
- User can make logs public or private
- Logs will automatically be drafts until 'Save' button is clicked
- CSS - Make it look really nice
- Tests
- Include a join model
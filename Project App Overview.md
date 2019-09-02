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
- content
- user_id  <-- foreign key

### Associations
- belongs_to :user


## Equipment

### Attributes
- camera
- lens
- speedlight
- drone
- accessories
- user_id
- log_id

### Associations
- belongs_to :user
- has_many :logs through :user


## Location

### Attributes
- name
- city
- state
- country
- user_id
- log_id

### Associations
- belongs_to :logs
- has_many :logs through :user


# MVP


# Strech Goals
- Like other members sample images
- User can make logs public or private
- Logs will automatically be drafts until 'Save' button is clicked
- CSS - Make it look really nice
- Tests
- Include a join model
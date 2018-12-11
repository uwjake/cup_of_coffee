# cup_of_coffee

## Demo slides
[https://github.com/uwjake/cup_of_coffee/blob/master/Final%20project.pdf](https://github.com/uwjake/cup_of_coffee/blob/master/Final%20project.pdf)

## Core user stories

- As a user, I want to take a picture of me and include my areas of interest/social media so that I can make my profile attractive [Done]
- As a user, I want to control my privacy setting so that I can let potential dates reach out to me as well as prevent myself from harassment [Done]
- As a user, I want to view a list of people near me so I can browse potential girl/boy I want to date [Done]
- As a user, I want to see how far they are from me so that I can find a reachable meeting spot for a cup of coffee [Done]
- As a user, I want to easily view profile details so I can determine who catches my eyes [Done]

## Optional user stories

- As a user, I want the app to provide me a match based on my areas of interest and/or location
- As a user, I want to send message to the one I’m interested in so that I can connect and chat with him/her [Done]
- As a user, I want to allow/request navigation between me and the other user. [Done]

## Mobile features used

- Realtime data and images from Firestore
- SMS/Email intents
- Apple map intents
- Location service
- Request camera/album to add a profile picture

## User Manual

A dating app based on realtime Firebase DB. Go ahead and find the one!

- Setup the profile (~7 screens)
- Once uploaded, click the person you like (Master/detail screen not avaible on 4.7-inch screen or smaller)
- See their profile (detail fragment)
- If you want to contact them, click Connect via email/phone (intent to other apps)
- Or navigate to them (intent to apple map)
- click my profile(right navi bar button in master list view) to see your profile (1 screen)
- If you don't want to share your location, turn off "Share My Location" switch in my profile page(update in realtime DB)
- click reset in my profile screen to change/reset your profile (start over)

## Set up

cd to project folder and run

```
pod install
```

## Open project

Double Click

```
cup_of_tea.xcworkspace
```

Do NOT use cup_of_tea.xcodeproj

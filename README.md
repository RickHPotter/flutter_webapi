# Alura Side

# VERSION 1

### 🛠️ This project is part of this [Alura course.](https://github.com/alura-cursos/flutter_webapi_first_course)

### ✔️ Techniques and Technologies

**What was built-in and/or used during Alura's Course** :
- `API`: What it is and how an API works in the internet;
- `http`: What HTTP is and its counterpart in Dart language;
- `async/await`: How to use `async` and `await` for asynchronous requests;
- `interceptors`: What interceptors are and how to use them aligned with HTTP;
- `logger`: For better visualisation of console and easier debugging;

## 🔨 Starting Project
![Alura Project](https://github.com/alura-cursos/flutter_webapi_first_course/raw/main/gif01.gif)

## Changes I have made to this project

### REST API

- Instead of using Node.js JSON-SERVER application to initiate a Fake Rest API, I did what I'd been planning all this time: build a basic REST API using GoLang. 
    - It's surprisingly more than decent for this project. I recreated the [baby project](https://github.com/RickHPotter/fake_rest_api) with the help of [this Laith Academy's video](https://www.youtube.com/watch?v=d_L64KT3SFM&ab_channel=LaithAcademy), which led me to build [this REST Api of my own.](https://github.com/RickHPotter/flutter_rest_api/tree/version_one)

### LOGIC

- Changed original `Journal.id` to `Journal.hash`, added `Journal.id` and `Journal.title`.
    - `Journal.id` became a checker. 0 is for updated both in the DB and the API, 1 is for Insert-Mode, 2 is for Update-Mode, -1 is for Delete-Mode.
    - `Journal.hash` is the original id automatically created using ([UUID](https://pub.dev/packages/uuid).
    - `Journal.title` is as it says, the Title.

- Refactored `journal.toJson()` and created `Journal.toJournal()` and `Journal.toListOfJournals()` static methods to make JSON parsing easier.

- Changed the whole logic of home_screen_list.dart:
    - The app name was an insight due to this layout. You can only create new entries in the last 7 days. Therefore 'Sept Jours'.
    - The most recent days are shown first.
    - I made it possible to have multiple diary entries in a single day.
    - Fixed the problem of `DateTime.difference()` by using someone else's snippet code `diffInDays()`.
    - `CreatedAt` is never changed, but `UpdatedAt` is, as it should
    
- Added [SQFLite](https://pub.dev/packages/sqflite) database for locally storing journal entries (I had problems trying to generate a objectbox file, so I went backwards to SQFLite).
    - HomeScreen is loaded using SQL SELECT instead of HTTP GET.
    - CUD operations start with Databases and only proceed to go to API when the API_Button is pressed.
    - Added an API_Button to merge DB and API contents.
       - What's in the local DB that's not in the API is sent.
       - What's only in the API is sent back to the DB. Hash, ([UUID](https://pub.dev/packages/uuid)-generated), being PRIMARY KEY, will take care of duplicates.

- Refactored out of AddJournalScreen a Widget that's used by AddJournalScreen, EditJournalScreen and ViewJournalScreen.
    - Remodelled 'add-journal' screen.
        - Added `db.prepareForInsert()`.
    - Added an 'edit-journal' screen.
        - Added patch request updating both `json:content` and `json:updatedAt`.
        - Added `db.prepareForUpdate()`.
    - DROPPED: Added a 'view-journal' screen.

### THEME

- Added colour differentiation for helpers/weekday.dart.
 
- Added [Slidable](https://pub.dev/packages/flutter_slidable) Widget.
    - Options are 'Edit' and 'Delete'.

- Added [QuickAlert](https://pub.dev/packages/quickalert) for `prepareForDelete()`, onPressed: () { `refreshFromDb()`; }, and onPressed: () { `retrieveFromApi()`; }

- Add colour dots to display on top right of Journal Cards.
    - Green is for updated both DB and API. Orange/Red is to be merged with the API.

- Added a Side Menu using [Shrink Side Menu](https://pub.dev/packages/shrink_sidemenu). It doesn't seem as smooth when changing tabs, but this will do.
    - HomeScreen() only offering 7 days. If you want to write on a day that's more distant than 7 days then I can only assume that day did not mean shit to you.
    - Overview() which will have every journal entry so far in block-like galleries.
      - DROPPED: When you click on them, it's a read-only view.
    - About(), about me, of course, and credits.

- Added a new icon using [FlutterLauncherIcons](https://pub.dev/packages/flutter_launcher_icons).
  - DROPPED: Trying to create another new icon that doesn't suck. 

## Things I didn't like about my project.

- I spent some unusual time on it and had somewhat a slow progress which is understandable for someone who hasn't done this before. It hasn't even been 2 full months studying Flutter, so there's that. So something I didn't like was not not having more time to produce, but not having more experience to produce faster.
- The Side Menu looks good but unnatural. I used a single key for every screen and that's just utterly retarded but I didn't find a way to refactor that out and share they key with everyone, so yeah, there's that.
- Typography is a key to UX, but I'm just a newbie. I think I used way too many fonts that most likely does not fit other app criteria.
- I wanted to make an only-view modal but ended up realising I was spending too much time on this, although same means to an end, I'd rather spend 30 minutes studying and maybe coming back to spend 30 minutes doing it, then spending 4 hours trying to do something I haven't been taught. I tried to create a second screen, and well it's there, but it honestly sucks, in my mind it seemed a good idea, but it looks ugly and maybe even unnecessary in the way I laid it out. Maybe in the future, I will undoubtedly know what do there. But for now, I need to keep going.

## Things I liked about my project.

- I like how natural it was to have plain project created and still feel the need to make some changes. This defeats the problem of Tutorial Hell. In this dreadful state many of us students happen to be in, we dwell in finding more and more tutorials to study but we don't learn, and that's because we don't make mistakes in tutorials, tutorials do not contemplate the mistakes we make along the way and looking them up is what make us more susceptible to learn how something works and why something doesn't work the way we wanted it to. 
- I was surprised I actually made it better, even visually. Second screen is useless and third screen was not supposed to be game-changing, but first screen is amazing, the slidable and quickAlert add a nice touch to the project making it more modern without taking out the simplicity of it.
- I was able to get some knowledge from other courses to this project. Apart from the obvious knowledge acquired during the WEBAPI Course Part I, I also inherited the Colour Dot, Theme Structure from [AluBank](https://github.com/RickHPotter/alubank) project, DB operation from [first project](https://github.com/RickHPotter/flutter_one). Good project to reunite with things I'd learned before.
- It was a dev-like two weeks for me, there was no Alura video playing on the side, no book to read, just Android Studio and the internet, this is somewhat what it's supposed to be, you need to make decisions yourself, even if they're bad, because if they are and you can spot them or accept them when someone spots them for you, you can learn how to make it better bit by bit.

## 🏠 Endgame
![My Project so far](https://github.com/RickHPotter/flutter_webapi/raw/master/gif.gif)


# VERSION 2

### 🛠️ This project is part of this [Alura course.](https://github.com/alura-cursos/flutter_webapi_second_course)

### ✔️ Techniques and Technologies

**What was built-in and/or used during Alura's Course** :
- `put`: What it is and how to use it to implement a change via API; // already implemented in my version
- `delete`: What it is and how to use it to perform a delete via API; // already implemented in my version
- `dialog`: How to create reusable `dialogs`; // already implemented using quickAlert, but will dig into it
- `headers`: How to utilise headers to make auth requests;
- `catchError`: A (soon-to-be) deprecated method of Future to handle asynchronous errors;

## 🔨 Starting Project
![Alura Project](https://github.com/alura-cursos/flutter_webapi_second_course/raw/main/gif02.gif)

## Changes I have made to this project

### REST API

- The same package was used to mock a REST API, this time with authentication and authorisation using JWT. Instead of giving and going the easy route, I polished my [flutter_rest_api](https://github.com/RickHPotter/flutter_rest_api/tree/version_two) to do the same. I had a lot of fun with this, which makes it even better to realise that working on both extremes can become handy and give you more power on whatever you're building.
- The version 0.1 of my API was not really RESTFUL. A JSON was storing state on the back end, which made no sense. That was changed by the coming of GORM / postgres implementation.
- User Model was implemented for Signup, Login and Logout endpoints.
- Added Middleware so that Diary Entry Operations were only available to those who were logged in.
- Added simple authentication and JWT authorisation.

### LOGIC

### THEME

## Things I didn't like about my project.

## Things I liked about my project.

## 🏠 Endgame
![My Project so far](https://github.com/RickHPotter/flutter_webapi/raw/master/gif1.gif)
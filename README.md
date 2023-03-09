# Alura Side

## 🛠️ This project is part of this [Alura course.](https://cursos.alura.com.br/formacao-flutter)

## ✔️ Techniques and Technologies

**What was built-in and/or used during Alura's Course** :
- `API`: What it is and how an API works in the internet;
- `http`: What HTTP is and its counterpart in Dart language;
- `async/await`: How to use `async` and `await` for asynchronous requests;
- `interceptors`: What interceptors are and how to use them aligned with HTTP;
- `logger`: For better visualisation of console and easier debugging;

## 🔨 Starting Project
![Alura Project](https://github.com/alura-cursos/flutter_webapi_first_course/raw/main/gif01.gif)

# Changes I have made to this project

## REST API

- Instead of using Node.js JSON-SERVER application to initiate a Fake Rest API, I did what I'd been planning all this time: build a basic REST API using GoLang. 
    1. It's surprisingly more than decent for this project. I recreated the [baby project](https://github.com/RickHPotter/fake_rest_api) with the help of [this Laith Academy's video](https://www.youtube.com/watch?v=d_L64KT3SFM&ab_channel=LaithAcademy), which led me to build [this REST Api of my own.](https://github.com/RickHPotter/flutter_rest_api)

## LOGIC

- Refactored journal.toJson() and created Journal.toJournal() and Journal.toListOfJournals() static methods to make JSON parsing easier.

- Changed the whole logic of home_screen_list.dart:
    1. The name came from this new layout. You can only create new entries in the last 7 days. Therefore 'Sept Jours'.
    2. The most recent days are shown first.
    3. Now it's possible to have multiple diary entries in a single day.
    4. Fixed the problem of DateTime.difference() by using someone else's snippet code diffInDays().

- Added [SQFLite](https://pub.dev/packages/sqflite) database for locally storing journal entries (I had problems trying to generate a objectbox file, so I went backwards to sqflite).
    1. HomeScreen is loaded using SQL SELECT instead of HTTP GET.
    2. CUD operations start with Databases and only proceed to go to API when the API_Button is pressed.
    3. Added an API_Button to merge DB and API contents.
       1. What's in the local DB that's not in the API is sent.
       2. What's only in the API is sent back to the DB. Hash, ([UUID](https://pub.dev/packages/uuid)-generated), being PRIMARY KEY, will take care of duplicates.

- Refactored out of AddJournalScreen a Widget that's used by AddJournalScreen, EditJournalScreen and ViewJournalScreen.
    1. Remodelled 'add-journal' screen.
        1. Added db.prepareForInsert().
    2. Added an 'edit-journal' screen.
        1. Added patch request updating both json:content and json:updatedAt.
        2. Added db.prepareForUpdate().
    3. TODO: Added a 'view-journal' screen.
        1. Add a Slide Menu with three options: Home Screen (7 days), Overview (Read-only, tappable to view-journal without option to edit), About (about me, obv).
        2. ?

## THEME

- Added colour differentiation for helpers/weekday.dart.
 
- Added [Slidable](https://pub.dev/packages/flutter_slidable) Widget.
    1. Options are 'Edit' and 'Delete'.

- Added [QuickAlert](https://pub.dev/packages/quickalert) for prepareForDelete(), onPressed: () { refreshFromDb(); }, and onPressed: () { retrieveFromApi(); }

- TODO: Add colour dots to display on top right of Journal Cards.
    1. Green is for updated both DB and API. Orange/Red is to be merged with the API.

- TODO: Added a Side Menu.
    1. HomeScreen() only offering 7 days. If you want to write on a day that's more distant than 7 days then I can only assume that day did not mean shit to you.
    2. Overview() which will have every journal entry so far in block-like galleries and when you click on them, it's a read-only view.
    3. About(), about me, of course, and credits.

- DOING: Trying to create a new icon that doesn't suck. Using [FlutterLauncherIcons](https://pub.dev/packages/flutter_launcher_icons). 

# Changes I'll make in the future

- More refactoring.
- Add Locale.

## 🏠 Endgame
![My Project](https://github.com/RickHPotter/flutter_webapi_1/raw/main/gif01.gif)
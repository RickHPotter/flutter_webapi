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

- Instead of using Node.js JSON-SERVER application to initiate a Fake Rest API, I did what I'd been planning all this time: build a basic REST API, yet more than decent for this project. This is the [baby project](https://github.com/RickHPotter/fake_rest_api) I recreated with the help of [this Laith Academy's video](https://www.youtube.com/watch?v=d_L64KT3SFM&ab_channel=LaithAcademy), which led me to build [this REST Api of my own.](https://github.com/RickHPotter/flutter_rest_api)
- Refactored out of AddJournalScreen a Widget that's used by AddJournalScreen, EditJournalScreen and ViewJournalScreen.
    1. _ \\
    2. Added an 'edit-journal' screen.
        1. Added patch request updating both json:content and json:updatedAt.
- Added colour differentiation for helpers/weekday.dart.
- Refactored journal.toJson() and created Journal.toJournal() and Journal.toListOfJournals() static methods to make JSON parsing easier.
- Changed the whole logic of home_screen_list.dart:
    1. The most recent days are shown first.
    2. Now it's possible to have multiple diary entries in a single day.
    3. Fixed the problem of DateTime.difference() by using someone else's snippet code diffInDays().

# Changes I'll make in the future

- Add a view so the order becomes (Index [BlankJournal] -> Add -> View -> Edit/Index), (Index [FilledInJournal] -> View -> Edit -> View -> Edit/Index)
- Theme Improvement
- Turn the FakeDatabase into a RealDatabase.
- New Icon
- New Name


## 🏠 Endgame
![My Project](https://github.com/RickHPotter/flutter_webapi_1/raw/main/gif01.gif)
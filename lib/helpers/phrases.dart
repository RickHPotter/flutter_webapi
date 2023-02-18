import 'dart:math';

String getRandomPhrase() {
  List<String> phrases = [
    'I\'m happy today because it\'s sunny.',
    'Raining too much lately.'
    'I studied a lot of Flutter today.!',
    'I helped someone on Alura Forums.',
    'I joined Alura Discord.',
    'I met someone who shot my dog three times today!'
  ];

  Random rng = Random();
  return phrases[rng.nextInt(phrases.length - 1)];
}

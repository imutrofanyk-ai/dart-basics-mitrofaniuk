// bin/task2_text_analyzer.dart
// Аналізатор тексту: слова, символи, речення, частота слів.

import 'dart:io';

/// Розбиває текст на слова (нижній регістр, без розділових знаків).
List<String> extractWords(String text) {
  final matches = RegExp(
    r'[\p{L}\p{N}]+',
    unicode: true,
  ).allMatches(text.toLowerCase());
  return matches.map((m) => m.group(0)!).toList();
}

/// Рахує, скільки разів кожне слово зустрілось.
Map<String, int> wordFrequency(List<String> words) {
  final freq = <String, int>{};
  for (final w in words) {
    freq[w] = (freq[w] ?? 0) + 1;
  }
  return freq;
}

/// Кількість речень = кількість груп знаків . ! ?
int countSentences(String text) => RegExp(r'[.!?]+').allMatches(text).length;

/// Найдовше слово (перше з найдовших).
String longestWord(List<String> words) {
  if (words.isEmpty) return '';
  return words.reduce((a, b) => b.length > a.length ? b : a);
}

void analyze(String text) {
  final words = extractWords(text);
  final freq = wordFrequency(words);

  // Сортування записів Map за кількістю (за спаданням)
  final top = freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  print('Characters (with spaces): ${text.length}');
  print('Characters (no spaces):   ${text.replaceAll(' ', '').length}');
  print('Words:                    ${words.length}');
  print('Unique words:             ${freq.length}');
  print('Sentences:                ${countSentences(text)}');
  print('Longest word:             ${longestWord(words)}');
  print('Top words:');
  for (final entry in top.take(3)) {
    print('  ${entry.key}: ${entry.value}');
  }
}

void main() {
  print('=== Task 2: Text analyzer ===');

  const sample = 'Dart is fast. Dart is simple! Is Dart fun? Yes, Dart is fun.';
  print('--- Sample text ---');
  print(sample);
  analyze(sample);

  stdout.write('\nEnter your own text (empty line to skip): ');
  final input = stdin.readLineSync();
  if (input != null && input.trim().isNotEmpty) {
    print('--- Your text ---');
    analyze(input);
  }
}

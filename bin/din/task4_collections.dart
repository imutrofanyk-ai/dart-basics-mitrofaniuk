// bin/task4_collections.dart
// Демонстрація List, Set, Map і функціональних операцій.

import 'package:dart_basics_mitrofaniuk/utils/data_processor.dart';

void demonstrateLists() {
  print('--- Lists ---');
  final marks = [5, 3, 4, 5, 2, 4, 5];
  marks.add(3);
  marks.insert(0, 4);
  marks.remove(2);
  print('marks: $marks');
  print('unique: ${DataProcessor.unique(marks)}');
  print(
    'sorted desc: ${DataProcessor.sortBy(marks, (m) => m, descending: true)}',
  );
  print('average: ${DataProcessor.average(marks).toStringAsFixed(2)}');
  print('median: ${DataProcessor.median(marks)}');
}

void demonstrateSets() {
  print('--- Sets ---');
  final dart = {'Ivan', 'Olena', 'Petro'};
  final sql = {'Olena', 'Anna', 'Petro'};
  print('union: ${DataProcessor.union(dart, sql)}');
  print('intersection: ${DataProcessor.intersection(dart, sql)}');
  print('only Dart: ${dart.difference(sql)}');
}

void demonstrateMaps() {
  print('--- Maps ---');
  final grades = <String, int>{'Ivan': 90, 'Olena': 95, 'Petro': 72};
  grades['Anna'] = 85;
  grades.update('Petro', (v) => v + 5);
  grades.putIfAbsent('Max', () => 60);
  grades.forEach((name, g) => print('  $name: $g'));
  final best = grades.entries.reduce((a, b) => a.value >= b.value ? a : b);
  print('best: ${best.key} (${best.value})');

  // Вкладена колекція: група -> список студентів
  final groups = <String, List<String>>{
    'ALK-44': ['Ivan', 'Olena'],
    'ALK-43': ['Petro'],
  };
  groups['ALK-43']!.add('Anna');
  print('groups: $groups');
}

void demonstrateAdvancedOperations() {
  print('--- Advanced ---');
  final nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final squares = nums.map((n) => n * n).toList();
  final evens = nums.where((n) => n.isEven).toList();
  final sum = nums.fold<int>(0, (a, n) => a + n);
  final max = nums.reduce((a, b) => a > b ? a : b);
  print('squares: $squares');
  print('evens: $evens');
  print('sum: $sum, max: $max');

  final words = ['dart', 'is', 'fun', 'and', 'fast', 'dart', 'is'];
  print('frequency: ${DataProcessor.frequency(words)}');
  print('by length: ${DataProcessor.groupBy(words, (w) => w.length)}');
  print('sorted by length: ${DataProcessor.sortBy(words, (w) => w.length)}');
}

void main() {
  print('=== Task 4: Collections ===');
  demonstrateLists();
  demonstrateSets();
  demonstrateMaps();
  demonstrateAdvancedOperations();
}

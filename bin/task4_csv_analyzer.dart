// bin/task4_csv_analyzer.dart
// Аналізатор CSV: читає студентів, рахує статистику, пише звіт.

import 'dart:io';

import 'package:dart_basics_mitrofaniuk/utils/data_processor.dart';

class Row {
  final String id;
  final String name;
  final String group;
  final int age;
  final int grade;

  Row(this.id, this.name, this.group, this.age, this.grade);

  /// Розбирає рядок CSV; null, якщо рядок некоректний.
  static Row? parse(String line) {
    final p = line.split(',');
    if (p.length != 5) return null;
    final age = int.tryParse(p[3].trim());
    final grade = int.tryParse(p[4].trim());
    if (age == null || grade == null) return null;
    return Row(p[0].trim(), p[1].trim(), p[2].trim(), age, grade);
  }
}

void main() {
  print('=== Task 4.3: CSV data analyzer ===');

  final file = File('data/students.csv');
  if (!file.existsSync()) {
    print('File not found: ${file.path}');
    return;
  }

  final lines = file.readAsLinesSync().skip(1); // пропускаємо заголовок
  final rows = <Row>[];
  var skipped = 0;
  for (final line in lines) {
    if (line.trim().isEmpty) continue;
    final row = Row.parse(line);
    if (row == null) {
      skipped++;
    } else {
      rows.add(row);
    }
  }

  final grades = rows.map((r) => r.grade).toList();
  final buf = StringBuffer()
    ..writeln('STUDENT REPORT')
    ..writeln('Records: ${rows.length} (skipped: $skipped)')
    ..writeln(
      'Average grade: ${DataProcessor.average(grades).toStringAsFixed(2)}',
    )
    ..writeln('Median grade: ${DataProcessor.median(grades)}')
    ..writeln(
      'Max: ${grades.reduce((a, b) => a > b ? a : b)}, '
      'Min: ${grades.reduce((a, b) => a < b ? a : b)}',
    )
    ..writeln('')
    ..writeln('By group:');

  final byGroup = DataProcessor.groupBy(rows, (Row r) => r.group);
  for (final entry in byGroup.entries) {
    final g = entry.value.map((r) => r.grade).toList();
    buf.writeln(
      '  ${entry.key}: ${entry.value.length} students, '
      'avg ${DataProcessor.average(g).toStringAsFixed(1)}',
    );
  }

  buf.writeln('\nTop 3:');
  final top = DataProcessor.sortBy(
    rows,
    (Row r) => r.grade,
    descending: true,
  ).take(3);
  var place = 1;
  for (final r in top) {
    buf.writeln('  ${place++}. ${r.name} (${r.group}) - ${r.grade}');
  }

  buf.writeln('\nGrade distribution:');
  final dist = DataProcessor.frequency(
    rows.map((r) {
      if (r.grade >= 90) return 'A (90-100)';
      if (r.grade >= 75) return 'B (75-89)';
      return 'C (<75)';
    }).toList(),
  );
  dist.forEach((k, v) => buf.writeln('  $k: ${"#" * v} $v'));

  final report = buf.toString();
  print(report);

  Directory('output').createSync();
  File('output/report.txt').writeAsStringSync(report);
  print('Report saved to output/report.txt');
}

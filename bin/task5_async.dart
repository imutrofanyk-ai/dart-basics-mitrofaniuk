// bin/task5_async.dart
// Асинхронність: Future, Stream, робота з файлами JSON.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'dart:io';

import 'package:dart_basics_mitrofaniuk/models/student.dart';

/// Імітує запит даних студента (затримка 1 с).
Future<String> fetchStudentData(String studentId) async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Data for student $studentId';
}

/// Читає студентів із JSON-файлу.
Future<List<Student>> loadStudentsFromFile(String filename) async {
  final text = await File(filename).readAsString();
  final list = jsonDecode(text) as List<dynamic>;
  return list.map((e) {
    final m = e as Map<String, dynamic>;
    return Student(
      id: m['id'] as String,
      name: m['name'] as String,
      age: m['age'] as int,
      group: m['group'] as String,
    );
  }).toList();
}

/// Записує студентів у JSON-файл.
Future<void> saveStudentsToFile(List<Student> students, String filename) async {
  final data = students
      .map((s) => {'id': s.id, 'name': s.name, 'age': s.age, 'group': s.group})
      .toList();
  await File(filename)
      .writeAsString(const JsonEncoder.withIndent('  ').convert(data));
}

/// Потік студентів: один елемент кожні 300 мс.
Stream<Student> studentStream() async* {
  final students = await loadStudentsFromFile('data/students.json');
  for (final s in students) {
    await Future.delayed(const Duration(milliseconds: 300));
    yield s;
  }
}

Future<void> demonstrateFutures() async {
  print('--- Futures ---');
  print(await fetchStudentData('S1'));

  // Послідовно проти паралельно
  var sw = Stopwatch()..start();
  await fetchStudentData('S1');
  await fetchStudentData('S2');
  await fetchStudentData('S3');
  print('Sequential: ${sw.elapsedMilliseconds} ms');

  sw = Stopwatch()..start();
  final results = await Future.wait([
    fetchStudentData('S1'),
    fetchStudentData('S2'),
    fetchStudentData('S3'),
  ]);
  print(
    'Future.wait: ${sw.elapsedMilliseconds} ms (${results.length} results)',
  );

  // Тайм-аут і обробка помилки
  try {
    await fetchStudentData('S9').timeout(const Duration(milliseconds: 200));
  } on TimeoutException {
    print('Timeout: request took too long');
  }
}

Future<void> demonstrateStreams() async {
  print('--- Streams ---');
  await for (final s in studentStream()) {
    print('Received: ${s.name}');
  }
}

Future<void> demonstrateFileOperations() async {
  print('--- File operations ---');
  try {
    final students = await loadStudentsFromFile('data/students.json');
    print('Loaded: ${students.length} students');
    for (final s in students) {
      s.addGrade('Dart', 80 + students.indexOf(s) * 5);
    }
    await Directory('output').create();
    await saveStudentsToFile(students, 'output/students_copy.json');
    print('Saved to output/students_copy.json');
    await loadStudentsFromFile('data/missing.json');
  } on FileSystemException catch (e) {
    print('File error handled: ${e.message}');
  }
}

Future<void> main() async {
  print('=== Task 5: Async ===');
  await demonstrateFutures();
  await demonstrateStreams();
  await demonstrateFileOperations();
}

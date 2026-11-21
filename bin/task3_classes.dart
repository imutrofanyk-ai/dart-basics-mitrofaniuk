// bin/task3_classes.dart
// Демонстрація ООП: класи, наслідування, інкапсуляція, поліморфізм.

import 'package:dart_basics_mitrofaniuk/models/course.dart';
import 'package:dart_basics_mitrofaniuk/models/person.dart';
import 'package:dart_basics_mitrofaniuk/models/professor.dart';
import 'package:dart_basics_mitrofaniuk/models/student.dart';

void main() {
  print('=== Task 3: OOP university system ===');

  final olena = Student(
    id: 'S1',
    name: 'Olena Koval',
    age: 19,
    group: 'ALK-44',
  );
  olena.addGrade('Dart', 95);
  olena.addGrade('SQL', 88);

  final petro = Student(
    id: 'S2',
    name: 'Petro Shevchenko',
    age: 20,
    group: 'ALK-44',
  );
  petro.addGrade('Dart', 72);

  final anna = Student(id: 'S3', name: 'Anna Melnyk', age: 19, group: 'ALK-44');

  final professor = Professor(
    id: 'P1',
    name: 'Ihor Bondar',
    age: 45,
    department: 'Software Engineering',
  );

  // У курсу лише 2 місця
  final course = Course(
    code: 'DART101',
    title: 'Mobile programming with Dart',
    credits: 4,
    capacity: 2,
  );
  professor.assignCourse(course);

  print('Enroll Olena: ${course.enroll(olena)}');
  print('Enroll Petro: ${course.enroll(petro)}');
  print('Enroll Olena again: ${course.enroll(olena)}');
  print('Enroll Anna (course full): ${course.enroll(anna)}');
  print(course);

  // Поліморфізм: список Person, але describe() кожного свій
  final List<Person> people = [olena, petro, professor];
  for (final p in people) {
    print(p.describe());
  }

  // Інкапсуляція: сеттер перевіряє значення
  try {
    olena.age = -5;
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }
}

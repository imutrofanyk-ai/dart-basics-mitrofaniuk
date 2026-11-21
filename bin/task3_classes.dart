// bin/task3_classes.dart
// Демонстрація ООП: класи, наслідування, інкапсуляція, поліморфізм, CRUD.

import 'package:dart_basics_mitrofaniuk/models/course.dart';
import 'package:dart_basics_mitrofaniuk/models/person.dart';
import 'package:dart_basics_mitrofaniuk/models/professor.dart';
import 'package:dart_basics_mitrofaniuk/models/student.dart';
import 'package:dart_basics_mitrofaniuk/models/university.dart';

void main() {
  print('=== Task 3: OOP university system ===');

  final uni = University('Krasnoarmiisk College');

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
  final anna = Student(id: 'S3', name: 'Anna Melnyk', age: 19, group: 'ALK-43');

  final professor = Professor(
    id: 'P1',
    name: 'Ihor Bondar',
    age: 45,
    department: 'Software Engineering',
  );
  final course = Course(
    code: 'DART101',
    title: 'Mobile programming with Dart',
    credits: 4,
    capacity: 2,
  );
  professor.assignCourse(course);

  // CREATE
  uni.addStudent(olena);
  uni.addStudent(petro);
  uni.addStudent(anna);
  uni.addProfessor(professor);
  uni.addCourse(course);
  print(uni);

  try {
    uni.addStudent(olena);
  } on StateError catch (e) {
    print('Error: ${e.message}');
  }

  // Запис на курс (місць лише 2)
  print('Enroll S1: ${uni.enrollStudent('S1', 'DART101')}');
  print('Enroll S2: ${uni.enrollStudent('S2', 'DART101')}');
  print('Enroll S3 (full): ${uni.enrollStudent('S3', 'DART101')}');
  print(course);

  // READ
  print('Found: ${uni.findStudent('S2')}');
  print(
    'Search "ann": ${uni.searchStudents('ann').map((s) => s.name).toList()}',
  );
  print('Top student: ${uni.topStudent?.name}');

  // UPDATE
  print('Update group S3: ${uni.updateStudentGroup('S3', 'ALK-44')}');
  print('S3 now: ${uni.findStudent('S3')}');

  // DELETE
  print('Remove S2: ${uni.removeStudent('S2')}');
  print('Remove S2 again: ${uni.removeStudent('S2')}');
  print(course);
  print(uni);

  // Поліморфізм
  final List<Person> people = [olena, anna, professor];
  for (final p in people) {
    print(p.describe());
  }

  // Інкапсуляція
  try {
    olena.age = -5;
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }
}

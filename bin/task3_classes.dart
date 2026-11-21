// bin/task3_classes.dart
// Демонстрація ООП: класи, наслідування, інкапсуляція, поліморфізм.

import 'package:dart_basics_mitrofaniuk/models/person.dart';
import 'package:dart_basics_mitrofaniuk/models/student.dart';

void main() {
  print('=== Task 3: OOP university system ===');

  final student = Student(
    id: 'S1',
    name: 'Olena Koval',
    age: 19,
    group: 'ALK-44',
  );
  student.addGrade('Dart', 95);
  student.addGrade('SQL', 88);
  print(student);

  // Поліморфізм: змінна типу Person, але викликається версія Student
  final Person person = student;
  print(person.describe());

  // Інкапсуляція: сеттер перевіряє значення
  try {
    student.age = -5;
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }
}

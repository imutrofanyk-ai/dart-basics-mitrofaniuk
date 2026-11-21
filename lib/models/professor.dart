// lib/models/professor.dart
// Викладач: наслідує Person, веде курси.

import 'course.dart';
import 'person.dart';

class Professor extends Person {
  String department;
  final List<Course> _courses = [];

  Professor({
    required super.id,
    required super.name,
    required super.age,
    required this.department,
  });

  List<Course> get courses => List.unmodifiable(_courses);

  void assignCourse(Course course) {
    if (!_courses.contains(course)) {
      _courses.add(course);
    }
  }

  @override
  String get role => 'Professor';

  @override
  String describe() =>
      '${super.describe()}, department $department, courses: ${_courses.length}';
}

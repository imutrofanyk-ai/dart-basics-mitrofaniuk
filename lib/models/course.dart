// lib/models/course.dart
// Курс: назва, кредити, обмежена кількість місць, список студентів.

import 'student.dart';

class Course {
  final String code;
  String title;
  final int credits;
  final int capacity;
  final List<Student> _students = [];

  Course({
    required this.code,
    required this.title,
    required this.credits,
    this.capacity = 30,
  }) {
    if (credits <= 0) {
      throw ArgumentError('Credits must be positive');
    }
    if (capacity <= 0) {
      throw ArgumentError('Capacity must be positive');
    }
  }

  /// Лише для читання.
  List<Student> get students => List.unmodifiable(_students);

  bool get isFull => _students.length >= capacity;

  /// Записує студента. false, якщо місць немає або студент уже записаний.
  bool enroll(Student student) {
    if (isFull) return false;
    if (_students.any((s) => s.id == student.id)) return false;
    _students.add(student);
    return true;
  }

  /// Відраховує студента з курсу. true, якщо такого студента було.
  bool unenroll(String studentId) {
    final before = _students.length;
    _students.removeWhere((s) => s.id == studentId);
    return _students.length < before;
  }

  @override
  String toString() =>
      '$code "$title" ($credits credits, ${_students.length}/$capacity students)';
}

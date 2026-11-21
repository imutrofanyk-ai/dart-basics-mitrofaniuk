// lib/models/student.dart
// Студент: наслідує Person, додає групу та оцінки.

import 'person.dart';

class Student extends Person {
  String group;
  final Map<String, int> _grades = {}; // назва курсу -> оцінка

  Student({
    required super.id,
    required super.name,
    required super.age,
    required this.group,
  });

  /// Лише для читання: зовні Map змінити не можна.
  Map<String, int> get grades => Map.unmodifiable(_grades);

  void addGrade(String course, int grade) {
    if (grade < 0 || grade > 100) {
      throw ArgumentError('Grade must be between 0 and 100');
    }
    _grades[course] = grade;
  }

  double get averageGrade => _grades.isEmpty
      ? 0
      : _grades.values.reduce((a, b) => a + b) / _grades.length;

  @override
  String get role => 'Student';

  @override
  String describe() =>
      '${super.describe()}, group $group, avg ${averageGrade.toStringAsFixed(1)}';
}

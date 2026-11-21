// lib/models/university.dart
// Університет: зберігає студентів, викладачів і курси (CRUD).

import 'course.dart';
import 'professor.dart';
import 'student.dart';

class University {
  final String name;
  final Map<String, Student> _students = {};
  final Map<String, Professor> _professors = {};
  final Map<String, Course> _courses = {};

  University(this.name);

  // ---------- CREATE ----------
  void addStudent(Student s) {
    if (_students.containsKey(s.id)) {
      throw StateError('Student ${s.id} already exists');
    }
    _students[s.id] = s;
  }

  void addProfessor(Professor p) {
    if (_professors.containsKey(p.id)) {
      throw StateError('Professor ${p.id} already exists');
    }
    _professors[p.id] = p;
  }

  void addCourse(Course c) {
    if (_courses.containsKey(c.code)) {
      throw StateError('Course ${c.code} already exists');
    }
    _courses[c.code] = c;
  }

  // ---------- READ ----------
  Student? findStudent(String id) => _students[id];
  Professor? findProfessor(String id) => _professors[id];
  Course? findCourse(String code) => _courses[code];

  List<Student> get students => List.unmodifiable(_students.values);
  List<Professor> get professors => List.unmodifiable(_professors.values);
  List<Course> get courses => List.unmodifiable(_courses.values);

  /// Пошук студентів за частиною імені.
  List<Student> searchStudents(String query) {
    final q = query.toLowerCase();
    return _students.values
        .where((s) => s.name.toLowerCase().contains(q))
        .toList();
  }

  // ---------- UPDATE ----------
  /// Змінює групу студента. false, якщо студента не знайдено.
  bool updateStudentGroup(String id, String newGroup) {
    final s = _students[id];
    if (s == null) return false;
    s.group = newGroup;
    return true;
  }

  // ---------- DELETE ----------
  /// Видаляє студента й відраховує його з усіх курсів.
  bool removeStudent(String id) {
    final removed = _students.remove(id);
    if (removed == null) return false;
    for (final c in _courses.values) {
      c.unenroll(id);
    }
    return true;
  }

  bool removeCourse(String code) => _courses.remove(code) != null;

  /// Записує студента на курс за ідентифікаторами.
  bool enrollStudent(String studentId, String courseCode) {
    final s = _students[studentId];
    final c = _courses[courseCode];
    if (s == null || c == null) return false;
    return c.enroll(s);
  }

  /// Найкращий студент за середнім балом (null, якщо студентів немає).
  Student? get topStudent {
    if (_students.isEmpty) return null;
    return _students.values.reduce(
      (a, b) => a.averageGrade >= b.averageGrade ? a : b,
    );
  }

  @override
  String toString() =>
      '$name: ${_students.length} students, ${_professors.length} professors, ${_courses.length} courses';
}

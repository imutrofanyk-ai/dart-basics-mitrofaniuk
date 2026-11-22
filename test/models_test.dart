// test/models_test.dart
import 'package:test/test.dart';
import 'package:dart_basics_mitrofaniuk/models/student.dart';
import 'package:dart_basics_mitrofaniuk/models/course.dart';
import 'package:dart_basics_mitrofaniuk/models/university.dart';
import 'package:dart_basics_mitrofaniuk/utils/data_processor.dart';

Student makeStudent(String id, String name, {String group = 'АЛК-44'}) =>
    Student(id: id, name: name, age: 19, group: group);

void main() {
  group('Student', () {
    late Student s;

    setUp(() {
      s = makeStudent('1', 'Іван');
    });

    test('average grade is calculated correctly', () {
      s.addGrade('Math', 80);
      s.addGrade('Dart', 90);
      expect(s.averageGrade, 85);
    });

    test('average grade is 0 when there are no grades', () {
      expect(s.averageGrade, 0);
    });

    test('invalid grade throws ArgumentError', () {
      expect(() => s.addGrade('Math', 150), throwsArgumentError);
    });

    test('invalid age throws ArgumentError', () {
      expect(() => s.age = -5, throwsArgumentError);
    });

    test('grades map cannot be modified from outside', () {
      s.addGrade('Math', 80);
      expect(() => s.grades['Hack'] = 100, throwsUnsupportedError);
    });
  });

  group('Course', () {
    late Course course;
    late Student s1;

    setUp(() {
      course = Course(code: 'CS101', title: 'Dart', credits: 5, capacity: 2);
      s1 = makeStudent('1', 'Іван');
    });

    test('default capacity is 30', () {
      final c = Course(code: 'X', title: 'Y', credits: 3);
      expect(c.capacity, 30);
    });

    test('non-positive credits throw ArgumentError', () {
      expect(
        () => Course(code: 'X', title: 'Y', credits: 0),
        throwsArgumentError,
      );
    });

    test('non-positive capacity throws ArgumentError', () {
      expect(
        () => Course(code: 'X', title: 'Y', credits: 3, capacity: 0),
        throwsArgumentError,
      );
    });

    test('enroll adds a student', () {
      expect(course.enroll(s1), isTrue);
      expect(course.students.length, 1);
    });

    test('enroll rejects duplicate student', () {
      course.enroll(s1);
      expect(course.enroll(s1), isFalse);
      expect(course.students.length, 1);
    });

    test('enroll rejects student when course is full', () {
      course.enroll(s1);
      course.enroll(makeStudent('2', 'Анна'));
      expect(course.isFull, isTrue);
      expect(course.enroll(makeStudent('3', 'Петро')), isFalse);
    });

    test('unenroll removes student and reports result', () {
      course.enroll(s1);
      expect(course.unenroll('1'), isTrue);
      expect(course.unenroll('1'), isFalse);
    });

    test('students list cannot be modified from outside', () {
      expect(() => course.students.add(s1), throwsUnsupportedError);
    });
  });

  group('University', () {
    late University uni;

    setUp(() {
      uni = University('КІПК');
      uni.addStudent(makeStudent('1', 'Іван Петренко'));
      uni.addStudent(makeStudent('2', 'Анна Мельник'));
      uni.addCourse(Course(code: 'CS101', title: 'Dart', credits: 5));
    });

    test('addStudent with duplicate id throws StateError', () {
      expect(() => uni.addStudent(makeStudent('1', 'Хтось')), throwsStateError);
    });

    test('addCourse with duplicate code throws StateError', () {
      expect(
        () => uni.addCourse(Course(code: 'CS101', title: 'X', credits: 1)),
        throwsStateError,
      );
    });

    test('findStudent returns null for unknown id', () {
      expect(uni.findStudent('999'), isNull);
      expect(uni.findStudent('1'), isNotNull);
    });

    test('searchStudents is case-insensitive', () {
      final found = uni.searchStudents('АННА');
      expect(found.length, 1);
      expect(found.first.id, '2');
    });

    test('updateStudentGroup changes group', () {
      expect(uni.updateStudentGroup('1', 'АЛК-45'), isTrue);
      expect(uni.findStudent('1')!.group, 'АЛК-45');
      expect(uni.updateStudentGroup('999', 'X'), isFalse);
    });

    test('enrollStudent works and rejects unknown ids', () {
      expect(uni.enrollStudent('1', 'CS101'), isTrue);
      expect(uni.enrollStudent('999', 'CS101'), isFalse);
      expect(uni.enrollStudent('1', 'NOPE'), isFalse);
    });

    test('removeStudent also unenrolls from courses', () {
      uni.enrollStudent('1', 'CS101');
      expect(uni.removeStudent('1'), isTrue);
      expect(uni.findCourse('CS101')!.students, isEmpty);
      expect(uni.removeStudent('1'), isFalse);
    });

    test('removeCourse reports result', () {
      expect(uni.removeCourse('CS101'), isTrue);
      expect(uni.removeCourse('CS101'), isFalse);
    });

    test('topStudent returns the student with the best average', () {
      uni.findStudent('1')!.addGrade('Dart', 70);
      uni.findStudent('2')!.addGrade('Dart', 95);
      expect(uni.topStudent!.id, '2');
    });

    test('topStudent is null when there are no students', () {
      expect(University('Порожній').topStudent, isNull);
    });
  });

  group('DataProcessor', () {
    test('unique removes duplicates', () {
      expect(DataProcessor.unique([1, 2, 2, 3, 1]), [1, 2, 3]);
    });

    test('average of numbers and of empty list', () {
      expect(DataProcessor.average([2, 4, 6]), 4);
      expect(DataProcessor.average([]), 0);
    });

    test('median for odd, even and empty lists', () {
      expect(DataProcessor.median([3, 1, 2]), 2);
      expect(DataProcessor.median([4, 1, 3, 2]), 2.5);
      expect(DataProcessor.median([]), 0);
    });

    test('groupBy groups items by key', () {
      final result = DataProcessor.groupBy([
        'ab',
        'abc',
        'cd',
      ], (String w) => w.length);
      expect(result, {
        2: ['ab', 'cd'],
        3: ['abc'],
      });
    });

    test('frequency counts occurrences', () {
      expect(DataProcessor.frequency(['a', 'b', 'a']), {'a': 2, 'b': 1});
    });

    test('sortBy sorts ascending and descending without changing input', () {
      final data = [3, 1, 2];
      expect(DataProcessor.sortBy(data, (int x) => x), [1, 2, 3]);
      expect(DataProcessor.sortBy(data, (int x) => x, descending: true), [
        3,
        2,
        1,
      ]);
      expect(data, [3, 1, 2]);
    });

    test('intersection and union of sets', () {
      final a = {1, 2, 3};
      final b = {2, 3, 4};
      expect(DataProcessor.intersection(a, b), {2, 3});
      expect(DataProcessor.union(a, b), {1, 2, 3, 4});
    });
  });
}

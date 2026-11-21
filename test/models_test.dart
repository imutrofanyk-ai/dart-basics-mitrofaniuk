// test/models_test.dart
import 'package:test/test.dart';
import 'package:dart_basics_mitrofaniuk/models/student.dart';

void main() {
  group('Student', () {
    late Student s;

    setUp(() {
      s = Student(id: '1', name: 'Іван', age: 19, group: 'АЛК-44');
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
}

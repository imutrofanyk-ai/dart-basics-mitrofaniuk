// lib/models/person.dart
// Базовий клас для всіх людей в університеті.

class Person {
  final String id;
  String _name; // приватне поле (інкапсуляція): символ _ на початку
  int _age;

  Person({required this.id, required String name, required int age})
    : _name = '',
      _age = 0 {
    // Використовуємо сеттери, щоб працювала перевірка
    this.name = name;
    this.age = age;
  }

  String get name => _name;
  set name(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
    _name = value.trim();
  }

  int get age => _age;
  set age(int value) {
    if (value < 0 || value > 120) {
      throw ArgumentError('Age must be between 0 and 120');
    }
    _age = value;
  }

  /// Роль людини; підкласи перевизначають (поліморфізм).
  String get role => 'Person';

  String describe() => '$role: $_name (age $_age)';

  @override
  String toString() => describe();
}

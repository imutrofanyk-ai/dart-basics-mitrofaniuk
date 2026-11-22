# Практична робота 4: Основи мови Dart

**Студент:** Митрофанюк Іван, група АЛК-44
**Спеціальність:** 121 «Інженерія програмного забезпечення»
**Заклад:** Красноармійський індустріальний фаховий коледж
**Середовище:** Dart 3.13.7, VS Code

## Опис

Набір консольних програм мовою Dart: базові типи й функції, ООП (університетська система), колекції та аналіз CSV, асинхронність (Future, Stream, JSON-файли).

## Структура проєкту

```
bin/
  task1_variables.dart      # базові типи, null safety, records
  task2_functions.dart      # функції, closures, higher-order
  task2_calculator.dart     # консольний калькулятор
  task2_text_analyzer.dart  # аналіз тексту
  task3_classes.dart        # демо ООП-системи університету
  task4_collections.dart    # List, Set, Map
  task4_csv_analyzer.dart   # аналіз data/students.csv
  task5_async.dart          # Future, Stream, JSON
lib/
  models/                   # Person, Student, Professor, Course, University
  utils/data_processor.dart # узагальнені утиліти для колекцій
data/                       # students.csv, students.json
output/                     # згенеровані звіти
test/                       # unit-тести
```

## Запуск

```
dart pub get
dart run bin/task1_variables.dart
dart run bin/task2_functions.dart
dart run bin/task2_calculator.dart
dart run bin/task2_text_analyzer.dart
dart run bin/task3_classes.dart
dart run bin/task4_collections.dart
dart run bin/task4_csv_analyzer.dart
dart run bin/task5_async.dart
```

## Опис завдань

1. **Типи та змінні:** `var`, `final`, `const`, null safety (`?`, `??`, `??=`), records.
2. **Функції:** іменовані й опціональні параметри, closures, `map`/`where`/`fold`/`reduce`; калькулятор і аналізатор тексту.
3. **ООП:** інкапсуляція (приватні поля з валідацією), наслідування (`Person` → `Student`, `Professor`), поліморфізм (`describe()`), CRUD у класі `University`.
4. **Колекції:** `DataProcessor` (унікальні, середнє, медіана, групування, частоти), аналіз CSV зі звітом `output/report.txt`.
5. **Асинхронність:** `Future.wait` (паралельно проти послідовно), `timeout`, `Stream` (`async*`, `await for`), читання й запис JSON.

## Тестування і якість коду

```
dart test
dart format .
dart analyze
```

Результат: 31 тест, All tests passed!

## Скріншоти
### Завдання 1: типи та змінні
![task1](screenshots/01_task1_variables.png)

### Завдання 2: функції, калькулятор, аналізатор тексту
![task2 functions](screenshots/02_task2_functions.png)
![task2 calculator](screenshots/03_task2_calculator.png)
![task2 text analyzer](screenshots/04_task2_text_analyzer.png)

### Завдання 3: ООП (університет)
![task3](screenshots/05_task3_classes.png)

### Завдання 4: колекції та аналіз CSV
![task4 collections](screenshots/06_task4_collections.png)
![task4 csv analyzer](screenshots/07_task4_csv_analyzer.png)

### Завдання 5: асинхронність
![task5](screenshots/08_task5_async.png)

### Результат тестів
![dart test](screenshots/09_dart_test.png)
Скріншоти виконання програм знаходяться в папці `screenshots/`.

## UML-діаграма (завдання 3)

```mermaid
classDiagram
    class Person {
        +String id
        -String _name
        -int _age
        +String name
        +int age
        +String role
        +describe() String
    }
    class Student {
        +String group
        -Map~String,int~ _grades
        +Map~String,int~ grades
        +double averageGrade
        +addGrade(course, grade) void
        +String role
        +describe() String
    }
    class Professor {
        +String department
        +List~Course~ courses
        +assignCourse(course) void
        +String role
        +describe() String
    }
    class Course {
        +String code
        +String title
        +int credits
        +int capacity
        +bool isFull
        +enroll(student) void
        +unenroll(student) void
    }
    class University {
        -Map~String,Student~ _students
        -Map~String,Professor~ _professors
        -Map~String,Course~ _courses
        +addStudent(student) void
        +addProfessor(professor) void
        +addCourse(course) void
        +findStudent(id) Student
        +searchStudents(query) List
        +updateStudentGroup(id, group) void
        +removeStudent(id) void
        +removeCourse(code) void
        +enrollStudent(studentId, courseCode) void
        +topStudent() Student
    }
    Person <|-- Student
    Person <|-- Professor
    Course "1" o-- "*" Student : записані
    Professor "1" o-- "*" Course : веде
    University "1" *-- "*" Student
    University "1" *-- "*" Professor
    University "1" *-- "*" Course
```

**Зв'язки:** `<|--` наслідування, `o--` агрегація (частина існує окремо), `*--` композиція (частина не існує без цілого).